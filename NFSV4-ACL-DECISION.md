# NFSv4 ACLs after removal of the NFS stack

## Purpose

This document records why code and interfaces named `NFSv4 ACL` remain after
the in-tree NFS client and server have been removed.  It is intended to support
a later decision about whether to preserve, rename, or remove that ACL model.

## Short answer

The NFSv4 ACL implementation is not part of the NFS client or server.  It is a
local filesystem access-control model whose semantics originated in the NFSv4
protocol.

FreeBSD currently uses that model independently of networked NFS for:

- local UFS filesystems mounted with `nfsv4acls`;
- the FreeBSD VFS interface to OpenZFS ACLs;
- kernel access checks and ACL inheritance;
- the public libc ACL API;
- `getfacl(1)` and `setfacl(1)`; and
- ACL-aware utilities and regression tests.

Deleting the NFS network stack therefore does not make this ACL implementation
unused.  Removing it would remove a supported local security feature and could
make existing UFS and ZFS ACL data inaccessible or incorrectly enforced.

The current recommendation is to retain the implementation.  If its remaining
`NFS4` names are undesirable, terminology and documentation can be considered
separately from the implementation and its compatibility requirements.

## What “NFSv4 ACL” means

FreeBSD supports two materially different ACL models.

### POSIX.1e ACLs

POSIX.1e ACLs extend traditional Unix owner, group, and other permissions with
entries for additional users and groups.  They broadly retain the familiar
read, write, and execute permissions, an ACL mask, and separate access and
default ACL concepts.

### NFSv4 ACLs

NFSv4 introduced a richer, Windows-style Access Control Entry (ACE) model.  An
NFSv4 ACL is an ordered list of allow and deny entries for principals such as:

- `owner@`;
- `group@`;
- `everyone@`;
- named users; and
- named groups.

The model provides more specific rights than Unix `rwx`, including:

- reading or writing file data;
- appending data;
- deleting an object;
- deleting children of a directory;
- reading or writing ordinary attributes;
- reading or writing named attributes;
- reading or writing the ACL itself;
- changing ownership; and
- synchronization.

It also provides per-entry inheritance controls, including inheritance by
files, inheritance by directories, no-propagate inheritance, inheritance-only
entries, and markers for inherited entries.

The relationship to NFS is consequently real: the vocabulary, ordering rules,
permissions, and inheritance behavior originated in the NFSv4 ACL
specification.  After filesystems adopt those semantics, however, the ACL
evaluator is also useful as local access-control infrastructure without an NFS
transport, client, or server.

## Independent local consumers

### UFS

UFS can operate with either POSIX.1e ACLs or NFSv4-style ACLs.  A UFS mount with
`MNT_NFS4ACLS` selects `ACL_TYPE_NFS4`, retrieves the ACL, and uses
`vaccess_acl_nfs4()` to make access decisions.  This is a local UFS mount using
the NFSv4 ACL security model, not an NFS mount.

UFS also uses the implementation to:

- recalculate ACLs after mode changes;
- inherit a parent directory's ACL when creating children;
- report support through `_PC_ACL_NFS4`;
- validate ACLs before storing them; and
- synchronize ACL permissions with Unix inode mode bits.

Nontrivial UFS NFSv4 ACLs are persistent data stored in an extended attribute.
If no extended ACL is present, UFS constructs a trivial ACL from the inode's
mode bits.  When an ACL is set, UFS stores nontrivial ACLs and synchronizes the
inode mode with the result.

Removing this support is therefore a data-format and security-semantics change,
not merely source cleanup.  Existing UFS filesystems may contain ACLs that need
the current implementation for interpretation and enforcement.

### OpenZFS

The FreeBSD OpenZFS vnode bridge accepts `ACL_TYPE_NFS4` for ACL retrieval and
setting.  It translates between FreeBSD's ACL representation and ZFS's native
ACE representation.  The OpenZFS kernel module also declares a dependency on
the `acl_nfs4` module.

ZFS ACLs are structurally closer to the NFSv4/ACE model than to POSIX.1e ACLs.
Removing the common implementation would therefore require at least one of the
following:

1. removing or reducing ZFS ACL support on FreeBSD;
2. changing OpenZFS to use a replacement FreeBSD ACL interface;
3. embedding equivalent ACL logic in OpenZFS; or
4. translating rich ACEs into POSIX.1e ACLs and accepting loss of semantics.

Deleting files merely because their names contain `nfs4` would not be safe.

### Kernel access checks

`vaccess_acl_nfs4()` is a common kernel authorization evaluator.  It maps VFS
requests to rich ACL rights, for example:

- `VREAD` to `ACL_READ_DATA`;
- `VWRITE` to `ACL_WRITE_DATA`;
- `VDELETE_CHILD` to `ACL_DELETE_CHILD`;
- `VREAD_ACL` to `ACL_READ_ACL`; and
- `VWRITE_OWNER` to `ACL_WRITE_OWNER`.

It then evaluates the ordered ACL against the caller's credentials, accounts
for file and directory behavior, applies owner protections, and returns the
access decision.  This is active security-enforcement code rather than unused
network serialization code.

### libc and the public ACL API

The installed ACL interface distinguishes `ACL_BRAND_POSIX` from
`ACL_BRAND_NFS4`, and distinguishes `ACL_TYPE_ACCESS` and `ACL_TYPE_DEFAULT`
from `ACL_TYPE_NFS4`.

libc contains NFSv4-specific support for:

- parsing and formatting text ACLs;
- permission and flag sets;
- ACL branding;
- validation and triviality checks;
- ACL inheritance; and
- conversion between ACLs and Unix mode bits.

The libc build compiles the shared NFSv4 ACL algorithms from the kernel source
so that userland and the kernel use compatible rules.  Public entry-type and
flag functions are also exported from libc.  Complete removal is consequently
an API and ABI decision as well as a kernel implementation change.

### Administrative tools

`getfacl(1)` and `setfacl(1)` ask each filesystem whether `_PC_ACL_NFS4` is
supported.  If it is, they request `ACL_TYPE_NFS4` and apply NFSv4-specific
formatting and modification rules.

For example, NFSv4 ACLs do not use a separate POSIX default ACL because
inheritance is represented by flags on individual ACEs.  Recursive `setfacl`
operations also treat inheritance flags specially when applying ACLs to
non-directory children.

These tools therefore exercise the feature on local filesystems even on a
system that never uses NFS.

## What remains related to NFS?

The relationship falls into three categories.

### Direct NFS dependency: removed

The former NFS client and server used this model to exchange and enforce NFSv4
ACL attributes across the network.  Those direct consumers were removed with
the NFS stack.

### Standards origin: retained

The following are derived from the NFSv4 ACL specification:

- permission names and values;
- ordered allow and deny evaluation;
- `owner@`, `group@`, and `everyone@` identities;
- inheritance rules;
- conversion rules between mode bits and ACLs; and
- names such as `ACL_TYPE_NFS4`, `ACL_BRAND_NFS4`, and
  `vaccess_acl_nfs4()`.

### Independent filesystem consumers: retained

The implementation continues to serve UFS, OpenZFS, VFS ACL operations, libc,
ACL utilities, and filesystems containing persistent ACL data.  These uses do
not depend on the deleted NFS network implementation.

## Decision options

### Option A: keep the implementation

This preserves:

- local UFS NFSv4 ACL mounts;
- ZFS rich ACL support;
- existing on-disk ACL data;
- libc API and ABI compatibility;
- `getfacl(1)` and `setfacl(1)` behavior; and
- current access-control and inheritance semantics.

The principal cost is retaining names containing `NFS4` even though the NFS
network filesystem is no longer present.

If this option is selected, the suggested follow-up is to document explicitly
that “NFSv4 ACL” identifies an ACL model rather than a dependency on an NFS
client or server.  The implementation, public constants, UFS and ZFS support,
tools, and tests should remain.

### Option B: rename the implementation

Possible neutral names include “ACE ACL”, “rich ACL”, or “ordered allow/deny
ACL”.  A wholesale rename would nevertheless provide little technical benefit
and would affect:

- installed public headers;
- libc symbols and constants;
- mount and filesystem flags;
- sysctls;
- user-facing output;
- OpenZFS integration;
- tests; and
- third-party source code.

Compatibility aliases would be required for old names, increasing complexity
without fully eliminating the terminology.  A rename should not be coupled to
the NFS-stack removal unless there is a separate compelling objective.

### Option C: remove only UFS support

This would require a policy for mounting or converting UFS filesystems that
already use `nfsv4acls`, preserving or converting extended ACL attributes, and
deciding whether tools may still inspect old data.

Because OpenZFS would still need the model, removing only UFS support would not
eliminate most of the common API or evaluator.  It would primarily reduce UFS
functionality and compatibility.

### Option D: remove the ACL model completely

Complete removal would be a separate filesystem, data-migration, security, and
ABI project.  It would require:

1. a UFS migration or rejection policy for `nfsv4acls` filesystems;
2. a replacement interface or reduced ACL feature set for OpenZFS;
3. removal or compatibility handling for kernel constants and interfaces;
4. retirement or adaptation of public libc APIs;
5. changes to `getfacl(1)`, `setfacl(1)`, and ACL-aware utilities;
6. conversion and rollback tooling for existing ACL data; and
7. extensive UFS and ZFS authorization, inheritance, and upgrade testing.

An automatic conversion to POSIX.1e ACLs would be lossy.  Ordered denies,
per-entry inheritance, delete-child rights, ACL-management rights, and
ownership rights do not all have faithful POSIX.1e equivalents.  A faulty
conversion could silently grant access that an existing deny ACE prohibited.

## Current recommendation

Preserve NFSv4 ACL support as an independent local filesystem security model
used by UFS and OpenZFS.  Its name and semantics derive from NFSv4, but it has no
runtime dependency on the removed NFS client or server.

Specifically, retain:

- `sys/kern/subr_acl_nfs4.c`;
- `ACL_TYPE_NFS4` and `ACL_BRAND_NFS4`;
- the NFSv4 permission and inheritance definitions;
- UFS `nfsv4acls` support;
- the OpenZFS bridge and module dependency;
- libc parsing, formatting, validation, and conversion support;
- `getfacl(1)` and `setfacl(1)` support; and
- ACL regression tests and manual pages.

The remaining removal-plan work should be a dependency audit and documentation
clarification, not deletion.  A later decision to remove this ACL model should
be treated as its own compatibility and data-migration project rather than as
residual cleanup from removing NFS.
