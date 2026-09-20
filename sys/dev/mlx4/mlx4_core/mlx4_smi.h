/*-
 * SPDX-License-Identifier: BSD-2-Clause
 *
 * Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
 * Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
 * Copyright (c) 2004 Intel Corporation.  All rights reserved.
 * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
 * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
 */

#ifndef _MLX4_SMI_H_
#define _MLX4_SMI_H_

/* Subset of the InfiniBand management ABI used by the mlx4 core driver. */
#define	MLX4_MGMT_CLASS_SUBN_LID_ROUTED	0x01
#define	MLX4_MGMT_METHOD_GET		0x01

#define	MLX4_SMP_ATTR_NODE_INFO		cpu_to_be16(0x0011)
#define	MLX4_SMP_ATTR_GUID_INFO		cpu_to_be16(0x0014)
#define	MLX4_SMP_ATTR_PORT_INFO		cpu_to_be16(0x0015)
#define	MLX4_SMP_ATTR_PKEY_TABLE		cpu_to_be16(0x0016)

#define	MLX4_PORT_DOWN			1
#define	MLX4_PORT_ACTIVE		4

struct mlx4_smp {
	u8	base_version;
	u8	mgmt_class;
	u8	class_version;
	u8	method;
	__be16	status;
	u8	hop_ptr;
	u8	hop_cnt;
	__be64	tid;
	__be16	attr_id;
	__be16	resv;
	__be32	attr_mod;
	__be64	mkey;
	__be16	dr_slid;
	__be16	dr_dlid;
	u8	reserved[28];
	u8	data[64];
	u8	initial_path[64];
	u8	return_path[64];
} __packed;

#endif /* _MLX4_SMI_H_ */
