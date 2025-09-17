Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66B2D3758
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118363; cv=none; b=NLQX+fp3UgX5HNl1U5zlz1b31n0hGMXcQt3uNplogNhTiePVYZGUvhSndgJ1y0/mmd6b5b2jOGMuaAc8fhlk/zRAijOKBEsoRKJA2CFhOplmz1Vt1IHr5jiOb/PUnPYEsmx783SnE5oB+Zy3PJTispj1isFtJIwOA/INK49qf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118363; c=relaxed/simple;
	bh=vAYyAJ+N5WTUxHpW/2g+4xRdn898OyOEJIqpwPj9b/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQXw95PXm13OId1/mgOZe0ghfp0npuEvrKXevKESJUe70yePZU1COpyIG9bwB4LScUU4EVDhgrONDnmTwwi3yq92NKORlijzL0971t+2SnkI0PAoYDBD7CXGcQZw/SlGTG/I8SAxZQS4WmQuqdJQoYy6WCpOt6Z5ups+uCdLFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBSG1lR1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBSG1lR1"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f5bfd0502so4300533a12.0
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758118360; x=1758723160; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvQvK494s3Wti/cOQyypkRIXGy03yU4MOudBoB5xafc=;
        b=kBSG1lR1j7JQF8c+lktfUlBqbpzBfugrZtuEIa5cltptHHi4cuxdd2uH6ATiMv6/X0
         xzlx0jgC1nN/yIlk4We0pZ/A89h68rsO2iaNE+noCpNUfnWYKE2WtFmSXMfhMYuxM9Yh
         d4V/PA9A0JqAxJ3BXsZS58k5IDfu+oMZqse6SIO4y6tV3l1ZoRfONzxzUgZsUIxEh/Lw
         erHfKuSglEHIKlF1qkH0qhv21USm6yxJHEhgxhuWddkndgOHWToJVEGSc4pprsI+PYeo
         O+Kc/8bnkRrJ0yt7pxzufOPxctxgKvNZFG6oCEZG6WNINE1cttg4eizbVnb7wQe3ciKv
         GMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118360; x=1758723160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQvK494s3Wti/cOQyypkRIXGy03yU4MOudBoB5xafc=;
        b=syDFPdnSH9rnZ7FRTH0YyqemmV6FPqHOCVMzsyxO8OzTM1J9Y/2qhZyB7q3HMAhV2q
         BQXS6bUB5DQyqwZNrU4qEXHpZJ3bMIBHNyKw+UNKs9P6zci1g9G4tHmS+GLt6DH5fDBa
         ZQSVsqn7ip/3zQoe+gewYHRX195iaV2WWF6VZ3qmm16eclzP4iJaXNhoA7TBznCOfj90
         cBOKub0aHtkzDFbVNyIweRjOQ6AGBjQgeGDLc9twvN0773UYJ/107boHQcpzvPm7fU4i
         qyX4S0OPY2QhsQBIlnPInnXx0QxpUYJWyM/OijUepiGyoOb6XKwhpmKiI182lp+AXxV6
         iVlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/HLR71JaubW6ablx0VG6Bu3oBFajRUf2N8cx3GMNluVTdYR/yYmOxfkDclHffBuJGrwZ4ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpIeZtDW3IUubX4p+d6n/B5pP100yzLl39lMGoms0xh1zB8R4C
	T4F0BWLiTUBNzNZU70h8ldI4FlEO09Vwc/3VhvzIh8jT3JFiqCXZ6j6GF8Svwx66S4Qiff1a3i0
	GxBBIfp+DG22RIeo2pTvvMR/NcUmp5UI=
X-Gm-Gg: ASbGncscm2vyZ+Sef9FcVwgH+QSiRLqBwHlY1WyNyqjSsXxTawzkGsb/wlxqmNLtdmk
	HMThEkHuXH2S1IxCH7hb3gOxQYssRZ4UygbLGOqvSsoqk2UNRi14Gr+/bc8swdIFWNGqZjSAwc7
	o216ygSPAcd7Q7fy+kUlffonfxkZK9Zo+xQOn/jYnF92xsc6X4hBV1P185OdMY7QHaBDI2fMvM7
	AoHgQEM4cIfWnlkXSZIQHb1j9XRorQVOwATVWw=
X-Google-Smtp-Source: AGHT+IE9tr65JazvM/P627oMjCH4lIxKxEXEjsbR4TaPhmEPiMyOp6W2xKFTSemRXPP2tElpIwdULTqBUJpCrnwZP+8=
X-Received: by 2002:a05:6402:280a:b0:629:949c:a653 with SMTP id
 4fb4d7f45d1cf-62f8422dd27mr2681936a12.24.1758118359355; Wed, 17 Sep 2025
 07:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
In-Reply-To: <20250917135907.2218073-1-max.kellermann@ionos.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 16:12:26 +0200
X-Gm-Features: AS18NWBVEzgWJelbyAZl8OravcOrQ3fPpZBJDvJxRNN-yXIAsbshHF34p8BX9gc
Message-ID: <CAGudoHF0+JfqxB_fQxeo7Pbadjq7UA1JFH4QmfFS1hDHunNmtw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:59=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> +/**
> + * Queue an asynchronous iput() call in a worker thread.  Use this
> + * instead of iput() in contexts where evicting the inode is unsafe.
> + * For example, inode eviction may cause deadlocks in
> + * inode_wait_for_writeback() (when called from within writeback) or
> + * in netfs_wait_for_outstanding_io() (when called from within the
> + * Ceph messenger).
> + */
> +void ceph_iput_async(struct inode *inode)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_add_unless(&inode->i_count, -1, 1)))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +

LGTM, I see the queue thing ends up issuing iput() so it's all good, thanks=
.

No idea about the other stuff it is doing concerning ceph flags so no comme=
nt.

> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* simply queue a ceph_inode_work() (donating the remaining
> +        * reference) without setting i_work_mask bit; other than
> +        * putting the reference, there is nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}
> +
