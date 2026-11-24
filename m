Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557943;
	b=Co9p2NnVHXJdIg6dV/3TFpB72Q6ywPpYrz8yXOEtcDCkjf/lARDDpAMxwUklN9ep9FWK
	 q3zIFIbfEmuKzdbgCgtFZluqsLbkYeds+XMtV6VHIURL7cujzJU4AKhiYSUWjZSpnIL9d
	 txk8oFjjYt3nARMaqa7DXKhHCDf6ytbAq2IUGCbijEE7SMs79V1TqlTj8Z0V/EH+P1u3P
	 u7KeUSKZ+6OxSnH8W1EmUBvyZtUqrSj+rzfz870J9e92JUDf5O5Zn4ZDU/ygn/nGO1jhy
	 7rdsrhQ5uiEoW6ICO2wx3PT4FvxD4i0RtYLYH6g3P3eLMlCm/59VMSseJENtrnTxvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557943;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Oim1PA6orX7kga6L+cEpR6I9TPT0HWQ3HYyAoE/h284=;
	b=0BQj4HwzimxR+R3O9XgvyrzOUN08/LOUMsecGABe3aePo8PU6mTqVaPuIMmp0y4+JzyC
	 sleU5Z3DNs8+BDoXVFIxukgfMdg0HAU1x1c7UiTp3ep4Qh3oxS1mUAPYuOsuw5MB08gAe
	 4RcZhNLyYJU1ezl+KAoXSo47ok4yunW4Gr3OQSRDbx2ImB4qtIuvwRbhdqhDJpawNB1p6
	 BFgQ3ZRDUpePyOVz7RKL6Q2KDfDd5/WcyncEHsCm/oE0/Xo1it/G4m2yMSCGkh59nC44E
	 gCxIymK64stR5pdPz3d5yaC7vqBUonCasRObekvwLu+uegw8V5lpOtym7/SaatIrhTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=awtyVIET;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A445606A31E
	for <netfs@lists.linux.dev>; Tue, 24 Nov 2026 22:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A445606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=awtyVIET
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOIYoad3378482;
	Tue, 24 Nov 2026 22:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Oim1PA
	6orX7kga6L+cEpR6I9TPT0HWQ3HYyAoE/h284=; b=awtyVIETeOs+D1vqb6F2eT
	0KbZuhnUmYbjZ83KJ42qa82eCLzTashYCxUA0Yn/enKR9bT3vksgYJIEDS4DgBwC
	Nvf/BQ1McofJJVPOWWiIyoOdjzV5+4oezqaOznoiO1pue4OKlwfdv7+5AL1J3tfQ
	QqK594h9ik2/hFYhx6Zs6OjWnb3+IBO5X50tw4PIRC9qwXZpnRBWfZhewA0nByPp
	W5W6BvAFgJjAhh7aEtLr8XKbzJSsWF3+KOKvex/ncMIjkhy1DCjl/8MmAYFVFQkL
	2IoraeD6kUL4Gpd7UXTuJsOJrDgZrreCI62sXTfexuerFob1VH6txRRRd+PpmrtQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa9vw4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 22:05:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOIZXOn3101415;
	Tue, 24 Nov 2026 22:05:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vme2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 22:05:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOM5GWG13042386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 22:05:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43C995805F;
	Tue, 24 Nov 2026 22:05:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B03F58051;
	Tue, 24 Nov 2026 22:05:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.243])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 22:05:15 +0000 (GMT)
Message-ID: <0313398fef7c1bd62ce4c3b849d581bdf90274ae.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: key iint mutex lockdep class per filesystem type
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
        Roberto Sassu
	 <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg	
 <eric.snowberg@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander
 Viro	 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara	 <jack@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Paulo
 Alcantara	 <pc@manguebit.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
        syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
In-Reply-To: <20261123111452.237422-1-ngocthang2710.1999@gmail.com>
References: <20261123111452.237422-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 17:05:14 -0500
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4NyBTYWx0ZWRfX4OFWzDGSQ2WD
 J+UQ8qCNws2CivQHNJJgVgg/r09Z/hzyT7CdevePuOLjm9KdYfYAVO2LwyR1i6h7MS/7NCM5DlO
 4XBBmJBjcJQs5rxN1Lw3x2fxtjMOsyfijPsFOqqCuS2pMoaEyaJxvUNuMxjQOlz0M+Rm2MhrAwD
 f7KeE/0LclmT5Ro8qeId1Iirp889BjQrFBYZ4BMPlTO+p+qmG71yZrB0kVk8WucPXvJhFJuSE9y
 9NHdU5TrYZmo4JuCfIKXiZsq+cicDLNRWyqADevpx6rrPhkirx0RfQEBXqPzYwVrqxY5jYTZROp
 69txb5qSU709HQ0o6uOrKySOhExMghFnjDQUGl6eEWenf9TkXCYGURYKG2OQ6KjuF+iWIw20WEs
 qzLNqiMwjz2vL0IsrkW8JbZbLSCuRcbsgM0JDJF/JiX+IFlC7RKFU+KhkM1sSlfrlS3OcbRdxx3
 9E7sAU9vxbtC0RLYPsA==
X-Proofpoint-ORIG-GUID: fp3D-BU5jMV_dZEIsh5uGRUlwktJXnDG
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b060a1e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=ec94T8KVA_HdOAEPGNsA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: RqfVn1-kZKWAXunhW2Y4UihtvoIdcOzw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4NyBTYWx0ZWRfX4OQMGnKahgJN
 +zwcAXlx6RZPLaBe+KsSlX3xShQDQrmvbWAgYukXK3ftLYui8YDmbXUSoRISeHkxipbf0SWXhGf
 ALgrZd6kbWtckQsfKq5sLFkN1XkbFx4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240087

On Mon, 2026-11-23 at 18:14 +0700, Nguyen Ngoc Thang wrote:
> syzbot reports a circular locking dependency between the iint mutex,
> a 9p inode's i_rwsem and the sb_writers of the cachefiles backing fs:
>=20
>   sb_writers#12 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_k=
ey#25
>=20
> The three edges are:
>=20
>   backing fs O_TRUNC open:  sb_writers(backing) -> iint(backing inode)
>   9p open + IMA hash:       iint(9p inode)      -> i_rwsem(9p inode)
>   9p truncate/writeback:    i_rwsem(9p inode)   -> sb_writers(backing)
>=20
> The last one is inherent to netfs: it writes to its cachefiles backing
> file under its own inode lock. The cycle only closes because the iint
> mutex is keyed by s_stack_depth alone, so the 9p and backing fs iints,
> both at depth 0, share one lockdep class. They are different inodes
> and nothing waits on a netfs iint while holding the backing fs's
> sb_writers, so this is a false positive.
>=20
> Key the iint mutex per filesystem type as well as depth, as is done for
> i_rwsem with s_type->i_mutex_key. The overlayfs case covered by the
> depth annotation is unchanged.
>=20
> Fixes: e044374a8a0a ("ima: annotate iint mutex to avoid lockdep false pos=
itive warnings")
> Reported-by: syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddeb8af81d91415fabac1
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Tested in QEMU on v7.4-rc4 (syzbot config, ima_policy=3Dtcb): cachefiles
> bound on an ext4 disk, 9p over virtio with cache=3Dfscache, then 50 round=
s
> of write + O_RDONLY|O_TRUNC open on 9p and on the backing fs, followed by
> 20 IMA-measured O_TRUNC opens through an overlayfs on the backing fs.
>=20
>   unpatched: "possible circular locking dependency detected", same chain
>   patched:   no lockdep report, debug_locks still 1; the syzbot C repro
>              also ran 90s with no report
>=20
>  include/linux/fs.h                |  3 +++
>  security/integrity/ima/ima_iint.c | 11 +++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)

Hi Nguyen,

Thanks for the patch. Keying the iint mutex per filesystem type, as is done=
 for
i_rwsem, makes sense to break the 9p/cachefiles cycle.

One suggestion: instead of an array of lock_class_keys in struct
file_system_type, consider using lockdep_set_class_and_subclass() with a si=
ngle
key and pass the stack depth as the subclass:

        lockdep_set_class_and_subclass(&iint->mutex,
                                       &sb->s_type->ima_iint_key, depth);

A lock_class_key already provides MAX_LOCKDEP_SUBCLASSES subkeys, so this g=
ives
the same distinct classes (overlayfs is unaffected) without allocating
FILESYSTEM_MAX_STACK_DEPTH + 1 full keys per filesystem type, and it avoids
having the array size in fs.h and IMA_MAX_NESTING in ima_iint.c defined
independently. A BUILD_BUG_ON(IMA_MAX_NESTING > MAX_LOCKDEP_SUBCLASSES) wou=
ld
keep the bound honest.

thanks,

Mimi

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5b3a100aba77b..dab32eea21fc7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2325,6 +2325,9 @@ struct file_system_type {
>  	struct lock_class_key i_mutex_dir_key;
> =20
>  	struct lock_class_key d_lookup_key;
> +#ifdef CONFIG_IMA
> +	struct lock_class_key ima_iint_key[FILESYSTEM_MAX_STACK_DEPTH + 1];
> +#endif
>  };
> =20
>  #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/i=
ma_iint.c
> index 00b249101f98d..bb964847af149 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -39,19 +39,22 @@ struct ima_iint_cache *ima_iint_find(struct inode *in=
ode)
>   * files both on overlayfs and on underlying fs, we need to annotate the=
 iint
>   * mutex to avoid lockdep false positives related to IMA + overlayfs.
>   * See ovl_lockdep_annotate_inode_mutex_key() for more details.
> + *
> + * Depth alone is not enough: a netfs inode writes to its cachefiles bac=
king
> + * fs under its own i_rwsem, and both are at depth 0. So, like i_rwsem, =
key
> + * the mutex per filesystem type too.
>   */
>  static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint=
,
>  					     struct inode *inode)
>  {
>  #ifdef CONFIG_LOCKDEP
> -	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
> -
> -	int depth =3D inode->i_sb->s_stack_depth;
> +	struct super_block *sb =3D inode->i_sb;
> +	int depth =3D sb->s_stack_depth;
> =20
>  	if (WARN_ON_ONCE(depth < 0 || depth >=3D IMA_MAX_NESTING))
>  		depth =3D 0;
> =20
> -	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
> +	lockdep_set_class(&iint->mutex, &sb->s_type->ima_iint_key[depth]);
>  #endif
>  }
> =20
