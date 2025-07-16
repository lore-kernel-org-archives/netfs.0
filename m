Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC824EB38;
	Wed, 16 Jul 2025 03:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636092; cv=none; b=VWNG1GnOpztPU7WhTWWR1LFHn+9gy8d0hRKYvkWcEMwnIqsutonyd721/WntF7V8iQfV6BDWSoTGjhhQycRgDeoup5tXs1IYbt2eieHVQ65wEUJMSuk/zImVbF7fc/FpPHVjdXJkDjIQBPN3Df/Eq74Jh9PohxorJIVp4l59OCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636092; c=relaxed/simple;
	bh=InUiyMm7gr3COTuSD5WM9WcRkq/+CKpu41nT3AXnmRI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IRfcAV0i0fFXwV7wF73HUBfjrlxg3C5ZtTBvMrvQxUCVaHFHZM+bkopKBXukWSpeRWjihjwfmFa3Ra3GAJ/HiEOczj67CesR1CpZoT1L4PPzSE6nMxlU5/gsGAM24Cj93Bw7wESTGw/Rh1KVyCQxVCXpNTO2IhrWKofXYRmFZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8A+wYsJ; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8A+wYsJ"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-2efbbf5a754so3687999fac.0;
        Tue, 15 Jul 2025 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752636090; x=1753240890; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=InUiyMm7gr3COTuSD5WM9WcRkq/+CKpu41nT3AXnmRI=;
        b=j8A+wYsJx+EWoDwx2KCyuKMw9OHa7qLQnOQ8YDDUuN7s6bsFSp+g700CM2RSqUbgFi
         k58uxWmkPqEIdI73GaL4y8710TmofRkZk9dp4JszQnpPQOZz5ONJ1HOMV3Aq7//6iIGi
         mr5aIE6I+T0xv4dwyAnr2hjHdADmT38ESyGt7ortlWg+LdXdDMy4X8OX53i4bQgTi5xz
         BxsNYz/46Yo6qADgDCLQNwKkO96sr1lmC7OS3h79Zi0u9JnPU8oskFkWVU5EBTJv/VFR
         GafU8Xc/6HIKklUA/RpCElnxQ2fyt4voTA7JD+g4KbrDZb0HcUK9OLHIDPkJWGiVkf1d
         mmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636090; x=1753240890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InUiyMm7gr3COTuSD5WM9WcRkq/+CKpu41nT3AXnmRI=;
        b=Umk6+R+vYNaGhnzvahoDe/AuL3zUp2wHIeW0LX0Fpg/v1MKuQiMlMjBuCZGsmGlSPx
         GWUmJm3e9Ks1JXAXS0fS6KOB3RVmZooHl7L/ffvMJP4PEP39UlPMaFiZCrYElELu13/s
         Uh0HifIk2nGk9gIQEd0X57NDjgaDheNkH77AfvPfHbP34QbP7FcZeQFe5OXRXSu+moqE
         FejHD+iHc/tdgnjoX4vhZGgxRBY+vQOzW4FypKHb3+2pKzy6eZ9gNRN4WwD2iMSPlZPy
         ZEQTOrquZZAvBaO9Swhv7FEeAWAR43eStSFccDN7m8Lo1c0RSSvSUsE5OHWMam3OzVbg
         5gbA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQSS97Au6PPc08jIW6FfYlRZQn8XNxCyXRqfcn7hMnPM0AGKlYJOeoJyqr1zdQnhUnK4hvT4=@lists.linux.dev, AJvYcCWFdsQFLQ7utaUK4w04uOE7N3XjFyjH6v/ZNZAnbCukeX7gYclTx3rk3T6eFpMhQDU3MFjqfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz7klU1+ioWXgNfBgpcCOVOPwGzSPUmM2Vxnnts/S8S2Xy0Ohz
	0sxs4VzBoun9me1rOLetmq5sAAtO4ol/q5QgmwtiqvuQQtzbgiesVfhC06EsezyP0LcjwE5CGpk
	2/yA+X1zuOSR+maanKPFxdnKMEKT9jl4=
X-Gm-Gg: ASbGncvhlRQaa3Cl42F63y6nfpi+OvGSIKB8hcrnWg5jTtUVrjwxFXnMb9r1F6PEgWn
	nAfZNjJ0lOmrqrkS9Vt3r460zaBIHA6vYWb8xRDjm1+VK1Uuwq73g7o5/RqXJPg49Y2mjj7bhfK
	KcUSMgI/I88n1UF/S7GpdA7Jcslnx4SzOuvAMzFogkv4t91I11BPtnSiIbWBruEltv6/3ms1YU4
	X+cnTY5ByJ+kh0m
X-Google-Smtp-Source: AGHT+IFyLwkV9mILJQbV+kbn7RjvFiGLh7yKX5x2YaAx2SKlK7xvUhTjS6vpStp4kfPeSkmgwOKnQtHPTOz5BVne74A=
X-Received: by 2002:a05:6870:d88a:b0:2d5:336f:1b5c with SMTP id
 586e51a60fabf-2ffb24d192amr988390fac.34.1752636090098; Tue, 15 Jul 2025
 20:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Date: Wed, 16 Jul 2025 11:21:18 +0800
X-Gm-Features: Ac12FXxyvfNuoq6EvJBxQuF0ETJxEKTBdNSnwB_ChV1lMjyZmff8pJLBThDiALw
Message-ID: <CAMLCH1HCPByhWGQjix6040fZuZhjkj19k=4pqmNzPDtGeZ0Q6A@mail.gmail.com>
Subject: Re: [f2fs-dev] Compressed files & the page cache
To: Matthew Wilcox <willy@infradead.org>
Cc: almaz.alexandrovich@paragon-software.com, Chao Yu <chao@kernel.org>, clm@fb.com, 
	dhowells@redhat.com, dsterba@suse.com, dwmw2@infradead.org, jack@suse.cz, 
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, linux-fsdevel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, netfs@lists.linux.dev, nico@fluxnic.net, 
	ntfs3@lists.linux.dev, pc@manguebit.org, phillip@squashfs.org.uk, 
	richard@nod.at, sfrench@samba.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Matthew and other filesystem developers,

I've been experimenting with implementing large folio support for
compressed files in F2FS locally, and I'd like to describe the
situation from the F2FS perspective.

> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.

Well, yes. F2FS's current compression implementation does compress
fixed-size memory into variable-sized blocks. However, F2FS operates
on a fixed-size unit called a "cluster." A file is logically divided
into these clusters, and each cluster corresponds to a fixed number of
contiguous page indices. The cluster size is 4 << n pages, with n
typically defaulting to 0 (making a 4-page cluster).

F2FS can only perform compression on a per-cluster basis; it cannot
operate on a unit larger than the logical size of a cluster. So, for a
16-page folio with a 4-page cluster size, we would have to split the
folio into four separate clusters. We then perform compression on each
cluster individually and write back each compressed result to disk
separately.We cannot perform compression on the whole large chunk of
folio. In fact, the fact that a large folio can span multiple clusters
was the main headache in my attempt to implement large folio support
for F2FS compression.

Why is this the case? It's due to F2FS's current on-disk layout for
compressed data. Each cluster is prefixed by a special block address,
COMPRESS_ADDR, which separates one cluster from the next on disk.
Furthermore, after F2FS compresses the original data in a cluster, the
space freed up within that cluster remains reserved on disk; it is not
released for other files to use. You may have heard that F2FS
compression doesn't actually save space for the user=E2=80=94this is the
reason. In F2FS, the model is not what we might intuitively expect=E2=80=94=
a
large chunk of data being compressed into a series of tightly packed
data blocks on disk (which I assume is the model other filesystems
adopt).

So, regarding:

> So, my proposal is that filesystems tell the page cache that their minimu=
m
> folio size is the compression block size. That seems to be around 64k,
> so not an unreasonable minimum allocation size.


F2FS doesn't have a uniform "compression block size." It purely
depends on the configured cluster size, and the resulting compressed
size is determined by the compression ratio. For example, a 4-page
cluster could be compressed down to a single block.

Regarding the folio order, perhaps we could set its maximum order to
match the cluster size, while keeping the minimum order at 0. However,
for smaller cluster sizes, this would completely limit the potential
of using larger folios. My own current implementation makes no
assumptions about the maximum folio order. As I am a student, I lack
extensive experience, so it's difficult for me to evaluate the pros
and cons of these two approaches. I believe Mr Chao Yu could provide a
more constructive suggestion on this point.

Thinking about a possible implementation for your proposal of a 64KB
size and in-place compression in the context of F2FS, I think the
possible approach may be to set the maximum folio order to 4 pages.
This would align with the default cluster size (especially relevant as
F2FS moves to support 16K pages and blocks). We could then perform
compression in-place, eliminating the need for scratch pages (which
are the compressed pages/folios in the F2FS context) and also disable
per-page dirty tracking for that folio.

However, F2FS has fallback logic for when compression fails during
writeback. The original F2FS logic still relies on per-page dirty
tracking for writes. If we were to completely remove per-page tracking
for the folio,then in compression failure case we would bear the cost
of one write amplification.

These are just my personal thoughts on your proposal. I believe Mr
Chao Yu can provide more detailed insights into the specifics of F2FS.

Best regards
