Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10A5381E;
	Sun,  1 Sep 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725234080; cv=none; b=j/4OZwGxMorsGACllL5Ub8fHI5kREM0C3tng7uCMZR24sV99PGpem3cpbJoDvq/ZCyvfJotOD1wnZ1pRMtaU6/CldxuiQ4f+ueATsD+3CSGT1KE2rbjBlrgoFHTNCkfJC1/1nf4hBQk6s64rIeYW9DMI1i14iGuhZv9bGu22DZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725234080; c=relaxed/simple;
	bh=MOF3+IXawLy9SIlMBfajQDdPJDqrahG9DjBoz/9HRR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOgZpEBsAM4IP0ekTYYDqkc7c/62Lp7plbe3S2VREwrKcKT65PfFeWLX0eBtSDuwvMWfk13hd10Hkb4jbzPXFNOwTUT86dI8kZjr9qzHOnS526jdsxj/UE/r1DjCSFAzeTbkIIP+O02qLi93mIuxhN+NXbfggYh2Dd8T0DRox8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqqJby8j; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqqJby8j"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f406034874so42614511fa.1;
        Sun, 01 Sep 2024 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725234077; x=1725838877; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OptCrhRONfMIpYiriIyIArvvwMoZ9X5KBzqF2jB2C8=;
        b=BqqJby8jbGcqBbpPOlzGIjZ+cImbspzbqMD7e6MJ6MB5Z23MLt9Oe7HYTWWYMFMbCe
         IfRrKKxc+PzRFMHHTkIuV5mdsuzFjIYEy5K2I2FgLJlJpMUxAHOTr7wgcb/8Kcqv4GPN
         McSd4ZhD50T2iFz9pnGVXT1CzHmRTdL0+UX/H6pbdePA/F4wOsWtO8u6F3AWcnf/RjRe
         PMommQH+LRlA9jchit3tFyVF4aWUu9MDhvjEIrtpZ46ISi6/FcMq2esQs4QdhMOoJpGh
         JHahZgpARZjgOD8VCo/eS2sxV+OtlfPIF0HqX4TARWz2bWiqoXgPIWkevNT9GGGNVzY4
         pAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725234077; x=1725838877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OptCrhRONfMIpYiriIyIArvvwMoZ9X5KBzqF2jB2C8=;
        b=Czx9oEZRXq3dLESrNaDPzjIg6XwBvQrI8yJMd+Tjsb00cl+Mx68FxCVfAZ/R8xnd2E
         tPPiJD1DfRUn5qq1LM+JkCbNWZ6uUDZZK2Dy7QbJRPEYcH/bUEJEGiVn6bd+TonL1ddD
         HpcdZjs32zeydkayHzN0mLSw17QE8ieDy22oqppilgxZkiSXiENMfaqsLGrMuC3beMcf
         W7KyQtQr5zDtOOaoNF8tiuUn22idNtEJ5aUKAKZglwVGUMcOicbcOJcQGfsRZwvwTkeQ
         pGDPWskjR6SliSsKr1nxaTxBOvOEqYz8Rixs0UjV13O5wGxyzolhSijBCKwmDz+b/uj8
         izAw==
X-Forwarded-Encrypted: i=1; AJvYcCWR/xUUGnb3ynrVH+nQpOL/agqN6LgYzRPI+VdJ5oM7tLblzQ/uqQS46c5+cvRfZBOBJQufFA==@lists.linux.dev, AJvYcCXkZ9kp7PoiU1LA3d3ugNTruC2ZBn8YrT4pAwwiDhHoCgBm7ZiI5Qd8ek7rin6LCt0vLiQwQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbDftoCvc2ZJ+zamx/ce9RaoSKeqNYiqpotoeVDsaQBjDsOv3G
	DtMnfpr71qpyyU43v9VExJKIzPqtbMPS57qhL1b8QcrXlKP8AFMRlGwr4fMIYvd1s5BoUNZUGeb
	xCOZ+cfEE6tTTtAbvMsvkQo6ChCo=
X-Google-Smtp-Source: AGHT+IHrpw2kTpvaZiyKJAHMxmQ/fhZpxqRdKI1vFWTY9ydD57nABAkwYo+y3SH1kUAvMU7Md95wbwacKxJ+67IyRxg=
X-Received: by 2002:a2e:be29:0:b0:2f5:23a:106b with SMTP id
 38308e7fff4ca-2f610890868mr90286721fa.34.1725234076595; Sun, 01 Sep 2024
 16:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240828210249.1078637-1-dhowells@redhat.com> <20240828210249.1078637-5-dhowells@redhat.com>
 <20240830-anteil-haarfarbe-d11935ac1017@brauner>
In-Reply-To: <20240830-anteil-haarfarbe-d11935ac1017@brauner>
From: Steve French <smfrench@gmail.com>
Date: Sun, 1 Sep 2024 18:41:05 -0500
Message-ID: <CAH2r5mv8merj9J=UK-U2xsSArL2s9zuRP-bZHnM39jU6Ujx9JQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, devel@lists.orangefs.org, 
	Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks like an important one as it fixes multiple xfstests see e.g.
with the patch:
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/213
vs without
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/212

Can add:
Tested--by: Steve French <stfrench@microsoft.com>

On Fri, Aug 30, 2024 at 8:12=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, 28 Aug 2024 22:02:45 +0100, David Howells wrote:
> > Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
> > rather than truncate_inode_pages_range().  The latter clears the
> > invalidated bit of a partial pages rather than discarding it entirely.
> > This causes copy_file_range() to fail on cifs because the partial pages=
 at
> > either end of the destination range aren't evicted and reread, but rath=
er
> > just partly cleared.
> >
> > [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_r=
ange()
>       https://git.kernel.org/vfs/vfs/c/c26096ee0278
>


--=20
Thanks,

Steve
