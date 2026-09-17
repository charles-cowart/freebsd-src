# NFS client and server removal

HalfBSD is removing its in-tree NFS client and server in stages.  The intended
scope includes NFSv2, NFSv3, NFSv4, pNFS, NFS-root, the Network Lock Manager,
NFS-specific RPC services, administration tools, startup integration, tests,
and documentation.

`NFS-REMOVAL-INVENTORY.tsv` is the authoritative, tab-separated removal
inventory.  Its columns are `status`, `action`, `phase`, `category`, `path`,
and `boundary`, so scripts can select work by phase or disposition without
turning an unsafe filename search into a deletion list.  Update the inventory
whenever an audit discovers another integration point.

## Boundaries

- Preserve generic ONC RPC, XDR, GSS, and `rpcbind` functionality unless a
  non-NFS dependency audit supports a separate removal.
- Preserve the NFSv4 ACL data model used by local filesystems during the NFS
  removal.  In particular, `subr_acl_nfs4.c` remains selected by UFS ACL and
  ZFS after its NFS-client selector is removed.  Phase 11 must revisit whether
  this implementation and its NFS-derived names should remain once NFS is gone.
- Preserve generic autofs functionality, but remove its NFS-specific maps and
  `/net` behavior in the userland phase.
- Do not confuse the NVIDIA nForce `nfsmb` SMBus driver or `unionfs` with NFS.
- Keep fixed syscall numbers as reserved ABI slots when retiring `nfssvc` and
  the NLM syscall; never renumber later system calls.
- Review imported passive protocol decoders separately instead of deleting
  files solely because their names contain `nfs`.
- Preserve BOOTP functionality that is independent of NFS during the staged
  removal.  Phase 11 must audit kernel and loader BOOTP consumers after the
  NFS-root code is gone and remove any implementation left without a purpose.

## Phase 1 — Inventory and freeze the boundary

- [x] Classify kernel client, server, common, NFS-root, and NLM sources.
- [x] Classify userland services, tools, rc integration, packaging, tests,
      tracing, loader support, documentation, and installed headers.
- [x] Record shared components and known false positives that must survive.
- [x] Add the machine-readable `NFS-REMOVAL-INVENTORY.tsv` handoff.
- [ ] Reconcile the inventory with install manifests before the installed-file
      cleanup phase; installed artifacts are deliberately not changed yet.

## Phase 2 — Disconnect kernel build and configuration integration

- [x] Remove NFS kernel options and NFS-root BOOTP options from
      `sys/conf/options` and `sys/conf/NOTES`.
- [x] Remove those options from architecture and board kernel configurations.
- [x] Disconnect NFS common, client, server, NFS-root, and NLM sources from
      `sys/conf/files`.
- [x] Remove NFS and NLM selectors from retained generic KRPC and XDR sources.
- [x] Preserve `subr_acl_nfs4.c` for UFS ACL and ZFS consumers.
- [x] Stop traversing NFS, NLM, and NFS DTrace kernel modules.
- [x] Stop installing public NFS kernel headers.
- [x] Remove the obsolete NFS dependency from the aggregate DTrace module.
- [ ] Build world and representative kernels on a FreeBSD build host.  This
      Linux workspace cannot execute the native FreeBSD build toolchain.

## Later phases

- [ ] Phase 3: delete disconnected kernel implementations and module sources.
- [ ] Phase 4: retire NFS/NLM syscall APIs while preserving ABI slot numbers.
- [ ] Phase 5: remove NFS userland programs and shared-utility branches.
- [ ] Phase 6: remove rc, configuration, package, and installed artifacts.
- [ ] Phase 7: remove loader and diskless NFS-root support.
- [ ] Phase 8: remove tests, tracing, protocol data, and documentation.
- [ ] Phase 9: audit residue and classify every remaining match.
- [ ] Phase 10: complete cross-architecture, upgrade, boot, and runtime tests.
- [ ] Phase 11: revisit the retained NFSv4 ACL implementation and BOOTP after
      all NFS dependencies have been removed.

## Phase 11 — Revisit NFSv4 ACLs and BOOTP

Perform this review only after the removal and validation phases, so decisions
are based on the actual dependency graph rather than assumptions made while NFS
is still present.

- [ ] Audit UFS, OpenZFS, libc POSIX.1e, archive/copy utilities, ACL tools, and
      tests for every `ACL_TYPE_NFS4`, `acl_*_nfs4`, and `vaccess_acl_nfs4`
      consumer.
- [ ] Decide whether the NFSv4 ACL implementation remains a supported local
      filesystem ABI, is renamed to protocol-neutral terminology, or can be
      removed.  Account for user ABI, on-disk behavior, archive interchange,
      ports, and OpenZFS compatibility before changing names or semantics.
- [ ] If the ACL implementation remains, update comments and documentation to
      explain why NFS-derived ACL semantics exist without an NFS stack.  If it
      is removed or renamed, provide the required compatibility and obsolete-
      file handling and rerun UFS and ZFS ACL regression tests.
- [ ] Audit kernel BOOTP options, `opt_bootp.h` consumers, architecture kernel
      configurations, diskless initialization, and loader BOOTP/DHCP/RARP
      support after NFS-root removal.
- [ ] Determine whether kernel BOOTP has a non-NFS boot consumer.  Remove its
      options, source, and documentation if none remains; otherwise move any
      retained implementation out of NFS-owned paths and document its owner.
- [ ] Preserve loader BOOTP/DHCP only where it still supports a retained network
      boot path.  Test that path independently of NFS and remove obsolete RARP
      or RPC fallback behavior rather than retaining it by association.
- [ ] Record both decisions in this file and update
      `NFS-REMOVAL-INVENTORY.tsv` from `investigate` to `preserve` or the
      appropriate completed removal action.

## Audit commands

Inspect and classify results; never pipe these searches into `rm`.

```sh
git grep -n -i -E '\b(nfs|nfsv[234]|pnfs|mountd|showmount|rquotad)\b'
git grep -n -E 'NFSCL|NFSD|NFS_ROOT|NFSLOCKD|NFSSVC|BOOTP_NFS'
git grep -n -E '<(fs/)?nfs(client|server)?/|sys/(fs/)?nfs'
git grep -n -E 'nfscl|nfscommon|nfsd|nfslockd|nfssvc|dtnfscl' -- '*Makefile*'
awk -F '\t' 'NR == 1 || $1 == "pending"' NFS-REMOVAL-INVENTORY.tsv
```
