Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD033E0088
	for <netfs@lists.linux.dev>; Fri, 25 Sep 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356058; cv=pass; b=OD6VfVONlAvOhrfzzrsn06xiOzKXx4VX+MAzRvowZylUv5dhjw5cWzQS7NNGu0DCTBbhnICJE6cpV/K6RxGo34n4htdyKd0eILWjfsiE9SU025QbcrL6hVe0SqXH/jMnz+Ru5YUTlvt9lr1zZXxVw3YvGmVZsfYmgsi3PGy5kpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356058; c=relaxed/simple;
	bh=Z/QlDjEqmTsvd8hmVsRhjPJAPZKduCsAshcn9SEcHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmQ5pusOSUIY/+/d3ufiQP0Zq8cA2rwfRc88h+s/G8CLB5BiBr3Mq3KaFVYcYl7KqmT72xI/mx6Otz2WHopvY1M+qJihZmX5uHmt2qOtrsblY4RKZq+QitS3qMHYim4e2zzUV8LsUx6RN9c+yQbEI+BeogRSAT/PtlpluXxJNj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XNzUdmCp; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XNzUdmCp"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df958a8272so4264805ad.3
        for <netfs@lists.linux.dev>; Fri, 25 Sep 2026 10:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356042; cv=none;
        d=google.com; s=arc-20260327;
        b=J0wHuClIKff/0RSC6eIR//GtcfJPf22IIeqM7chc3TBHHCyVw1q/RXFwGFwUf7bLQC
         Sk60G/VY88JtRy+5SNdZNi3L5dg9JZtNZge5E4skoGytaj65GEaX0ank1P7N85xEBIK2
         x4ZoKGaAi0IhN8NvxOKwrR6lCUvu06csmREFRKKLzLrpR/VPiSeKTZXZWylAO6uXBu8F
         RWSeobvvKWrlYW/KpcbUBjX0bCbKQhCJQ7/t/F+KMT5kc+t+cTxruvPEW8aLyc0ntwOQ
         y1Pm+oJ10zpjlR7qL31gxL1tzS44qOKY1XJLdlBPtcrpzliXpCkE/9wBe7E9G8Mg5CSg
         BObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        fh=U/KVhHRCTRbpSNLWF/Scc38DAltRPtotQEeJV9C0B7Y=;
        b=CyapStoILC9PxXBwseGhQPaDMDk8PVZRPlhlkz+SH7KXiMWkeGVUcq1KwuCv/j3RWA
         TBN2E6qtEIEpRjQrIXQG+ZpE+eQOrLgYkciziswYxXBvNuhK5/UJv8YEY2cs6SyJCScx
         FYLe071gBk3jS0o1oN6ZKLSq3N5ynolBFpzwEAZCBLO4H52gxbZYK9KFbKR+UpUF9F9q
         qoUzDDtPQj/j5tc8BnHsMBnywMzFsKN3h0yUvoZMyjTmeoBGodSFDrpkdduF/b1nXYOf
         H4ITL/1m/yHFGcJ7MXeV0JUwZ5bwh7Of9TXn9gGty3Gj0YDX+GmoVm45nDnsiW2EuLQ2
         FoQQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790356042; x=1790960842; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=XNzUdmCpnd1ky36YmO7X604JgVUPNvaQIjSba1rhMLZp8b7A23jp9GfXpAaunHzp+u
         RhJ8/R0ms7rIJXHT32bAkPuJ511YQjBsWEsr9NVaiNrwLmegSaY8ETh4G7SZIDpw6a3G
         HLQIkaLbSTbnhlqS23geQcFGca025RxwAKtSLnwRJTPK4MsG/e41JVkXI0l5kOoqOxcW
         Ot5KA1kx8BdjqMqYh1k7bV/6JzENC9xrb2pM93sFd8lt3FPWBR5L8NnFU8+IvI1sw2oW
         uiHON8+ajIN4JmtVQ/wOjlDDYcKyoyDprNBgvoYxJMJX3NKBwCluVoUOfVV21MVjlVoy
         q5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356042; x=1790960842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=XqQ1+FNWHKdLhhyukHO/RUFa0mD/wzx6YJguE4rw+TjzwEN9TeFgc7zb3IQSos17US
         uB7cvlSHSiGj5SJkDGSvxKH3hZDAWb8PvfEVJvyZxKLcnzc3uv2wsPd4mNKvIjSZ4siR
         QEI+f7s7LjyzWBq088SlUNhaJNH9MgoVxlOwk/FL2Cy6KETDGygC8HNlyA9ZQKLNbU6U
         ZDIqAWrEL8GIpYg7SAjRgyL7wdNFqXcMKKxQry3tawHir+uGSVV5eCdHAtCfp6ubutLp
         VR7JOIwD93kfgzYZhPKMsunxBe9FpcBOiRCfG2UlAnK5z3GyNZXEoWoR40RXd/yKqHKI
         82+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwMv2ngdhpXd8KZUhcRfV+JXKQ2TO9dst6i0H8DPfScdOT2glzX0CQpLNFbXKSP3/dv7ToIVg==@lists.linux.dev
X-Gm-Message-State: AFuF++musTqFz8i8OzybkybaZ+gTPLwiEnpolnBCg3/aOXATFB4/dCBN
	PR7xv3hSyujkfHqyiNmn6VwKlM9U26k3AfzHw6rMCWH+LR071GszqrPQG4Lpl98UlDss3mv85di
	95gVuKKL/3m49iZAET15ywWIsiKg5TvzEVFGvTqNS
X-Gm-Gg: AYBFou2sQNwKyflt5PNKLpE99SD5d5p/pHViLWITwaDbXtGjMv4bB5cF42xYC1wtq6Q
	bXbT/Toi40Mi+2IqHLP97rjOjjjy52oapAv0EP22Wl7ArtUhMIdGFztQ0CG/WTtFYNiljUVDZCW
	2r9S9eiHFz0FnntDleGArm2e8bLSrBHuMCAOiw8ozPmFRnb+WvSx9OMkt+lQCyHguwIFR17/YeQ
	V9FiCgO/j1ixjUmPrr/pK69GZzH2OMa6z76n0WbypE3ZZqhm9alJgT4Q5ouF3a8FrXL8nfZhKBn
	r8Mdu53SicLl81Zb2j0WG2ZqxLX348wIjkEM2bTGs1BFdATUOhM7jOkuuCliiz5c4kv9rFi7LNy
	C2oNiwlL3l22YKw9RdMeXaQ==
X-Received: by 2002:a17:902:d48d:b0:2df:99e6:9448 with SMTP id
 d9443c01a7336-2df99e695bbmr12902675ad.61.1790356042370; Fri, 25 Sep 2026
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
In-Reply-To: <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Sep 2026 13:07:08 -0400
X-Gm-Features: AclHuK-PYyMWIn_xv6i13K6lF_3RP26uUOO_mtAnUMGHNcMrV5ydBitx8qn_ri0
Message-ID: <CAHC9VhSeXmOHvioZ12aVmnOtpP52-G=K_jS3K0fTSiCrDHStPw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Cai Xinchen <caixinchen1@huawei.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, jack@suse.cz, dhowells@redhat.com, code@tyhicks.com, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	miklos@szeredi.hu, amir73il@gmail.com, senozhatsky@chromium.org, 
	chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed i=
n
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
>
> This is mostly fine for me. @Michael, for the fs side of things I would
> give you a stable branch vfs-7.*.shared.landlock.path that you can pull
> once this is ready.

This is in my queue, but I haven't reviewed the changes yet.

@Christian, I'm guessing you will merge patches 1/12, 3/13, and 4/12
since those are the VFS changes?  Once you have a branch for that, and
we have all the necessary ACKs, I'll merge the LSM changes in 2/12,
5/12, 6/12, and 7/12 and then Micka=C3=ABl can merge the Landlock patches.

Are we all okay with that?

--
paul-moore.com
