Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D03C3457
	for <netfs@lists.linux.dev>; Tue,  5 May 2026 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961519; cv=none; b=l5eMb4NGphHq9wjoEcmszWT/koLpxET5foWSOjNqYKm35rgFRvmRTKmigCJcPPGWvVMiQMU9f+6XZsM2mRslBiivnvK9Pl5kFdZtrO8AkZFBSxVqQbfIRZVTbmbq/t56IEkfkfEkwj/3iTCOw1qD922Gj2gHuJkQV33eh1MjhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961519; c=relaxed/simple;
	bh=3RwYYy8oQs7B3Nh+ZfPDXaEpMDZlE/1vWf/pCAzCJp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tH6GfGMR+PhZt0KMl3tUYS6H1WDpG9rZLB8PnfLxYf+5ZaaktMH9wnLE+otE/9b3plym6Q9JwY8FmDGXV6uRqFMtns6Rp7T2l4jDlLnp8Ofzzekd4gVHEHefzoyVN1eY02tDOgJ2lhnpJSMJ2gQ9IBaPFkDYOgqDFjvCxr2aLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAYPoVKr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAYPoVKr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso2170401b3a.0
        for <netfs@lists.linux.dev>; Mon, 04 May 2026 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777961517; x=1778566317; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+wwvpFMRip9QGwFsLUcpUYYHp8W07YpxKheBhhRTr4=;
        b=YAYPoVKrifrlm8eOZj1pXkMefgfY3CytoP8nu1XtctgS3eTN06GN4mLZ/AEss7xgyg
         AbGvDlHaLvEihVV8gO/HspiKqZL2COPswrxObn4/PopIwb8dXTDpcqCweqRgpCOcZ2v0
         e7qhbs4y6NptKe4rulNpCWXpU1SZ0kauUpwkjhsnCu5fFDmyFtWjr78TALAol1qGPavB
         YdUPhNwH2z74hWu2BtNqz7b81Za0Bv5wiPD1eIgc1fgukw88EeMvUGT3ErTp6J98oraz
         E8y6oWtcTHa0Wcp5r47m4tTxuEwYOw/czFcGozyUM0xmmuBR9BtNY5qoM08QKjo9vVSP
         UT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777961517; x=1778566317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+wwvpFMRip9QGwFsLUcpUYYHp8W07YpxKheBhhRTr4=;
        b=jbz2CExTJ5tJNTlbKaCRCFjeSWlodErwDwECNVpvjlt/EZmIqv2y3z7BfmaCHugMSL
         ipfA67B4XxO96FE+A+uKrh4cOBb/ndy3wCEeu7RgzbJnvuMFcvTLeij8BfxT2UfDIhlN
         AVzS0WmbQahKGZhwjkcNmtHqCDjSEAXLV7dz4mT0lk6P3vDZ9l7gTHH2OWGLVoXQzFA7
         HpNF1ttvzhVC5U2X5eDNsO/ZLGs0E5rndAjvA4lLd0Mi5sRj0AGEefRDBIDpUsW1VF0c
         j35ZsopJ5Shs/yDqS7E+nAlOrjBge4yBR8oGoXE1s60VlQBRwhtVQEmI1kgAq9lH3Zwx
         7CUA==
X-Forwarded-Encrypted: i=1; AFNElJ9wj8m/MUHKaKNK6iI57QaO2pg1VPXW/F2Iqna3bmF1PCCbQ7uzi1+ebTY/BUa4pvw44ybBjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXM21f9DsGquuBoizc1G+Ua6wdCH6uhgI5BYUFN8xo7XI1JcgS
	EUk7BlbK74win5Ui0EVzCwRim8gyuergq6caW9MMRI3+N/kSxNt0BANHkVOcmg==
X-Gm-Gg: AeBDiesauSM+/vMfRaSYqJih3W39DzAh8ZMicEQcsCJ1NfJzyOdTM1jtfEYXxT0Xwal
	GC2r/Dtd3O9q9gG4nV/gKCmbsdAiziCQr7R5tzJ/mZM2tbAEnrkuxIbwgBYdPySaU+WQmTe0OJj
	pjr3cUTjGHpvPmRopC7soi8RZ4OHSHSupbaprEZI+8ZdmpnJGgnRe9/8vf6/7eQlCGhnzrrwRCe
	l+wMz+udzOx2x3+rfxTo9fjD8c6dGkcySw1ilCemfL18QfJXA3LVkBxHoPyTaIABr4tgqRJLhdA
	Mn9pc9zKD/ykkjBuzZtrcECMqYyeG0c18c9P6A4BFtPNEFBAwH2HxRphsgubkXzScLqGiyBW9J3
	2HWvukXWxcNL3IVzrg/YSqVvTKRm4y85iWCNJPSW2vBILBXbEIfLL1l+9o1uYwmHRpwWxj1PvWO
	Ns8I1Fo0+vhZrGIHLq6usn39CVY7nhT5cH4Y8m/tEqLaaSyfNz
X-Received: by 2002:a05:6a00:4f88:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-839227d1216mr1744350b3a.14.1777961517008;
        Mon, 04 May 2026 23:11:57 -0700 (PDT)
Received: from localhost ([49.207.150.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdda0sm903484b3a.44.2026.05.04.23.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:11:56 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
To: linux-fsdevel@vger.kernel.org,linux-cifs@vger.kernel.org,linux-nfs@vger.kernel.org,netfs@lists.linux.dev
Cc: sprasad@microsoft.com,linux-kernel@vger.kernel.org,sfrench@samba.org
Subject: [DISCUSSION] Preventing ENOSPC/EDQUOT writeback errors on network
 filesystems
Date: Tue, 05 May 2026 11:41:53 +0530
Message-ID: <m21pfqgzbq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
There have been plenty of discussions on how to handle writeback errors for
network filesystems, but most have focused on error reporting after the fac=
t.
I'd like to start a discussion around preventing writeback errors specifica=
lly
ENOSPC and EDQUOT, before they cause silent data loss.

The problem:
With buffered writes on network filesystems (cifs, nfs, etc.), the write()
syscall copies data into the page cache and returns success immediately. The
actual upload to the server happens later during writeback. If the server is
out of space at that point, the write fails with ENOSPC. The netfs/writeback
layer records this error via mapping_set_error(), but critically the folio's
writeback flag is cleared and the page is now clean. Under memory pressure,=
 the
VM can reclaim these clean pages, permanently losing data that the applicat=
ion
believes was successfully written. Meanwhile, i_size has already been updat=
ed
to reflect the new file size. So stat() shows a file size inclusive of the =
data
that was never persisted. Another inconsistency here is that total free spa=
ce
hasn't been modified for the file system on the server, leading to incorrect
values in statfs() output from the client's pov (assuming statfs() calls go
to the server).
To illustrate with real-world scenarios:

- A user or application can keep issuing writes to an fd well beyond the
  available space, since buffered writes return success as soon as data is
  copied to the page cache. A significant amount of data, exceeding the
  available quota can accumulate before fsync() is called, at which point
  critical data loss is nearly certain.

- A malicious user can exploit this to keep resources pinned and memory
  oversubscribed, impacting other applications.

The error is technically observable: fsync() will return it, and close()
surfaces it through the flush callback. But in practice, many applications
check neither, and the POSIX "just call fsync()" answer isn't satisfying for
users who lose data silently.

Local filesystems largely avoid this because they can check available space
synchronously in write_begin() and fail the write() syscall directly. Netwo=
rk
filesystems can't do this cheaply =E2=80=94 a round-trip per write to check=
 server
space would negate the benefits of buffered I/O.

Through recent development, netfs is becoming a central layer for network
filesystem I/O. It already has retry logic for transient failures (EAGAIN,
ECONNABORTED), but ENOSPC/EDQUOT remain hard failures. This affects every
network filesystem using buffered writes.

I am curious to know if NFS has a solution to this and what the approach is
towards this specific problem by NFS community?

This problem is worth solving for all network filesystems. I have a few
thoughts on approaches, combining cached statfs() output with
fallocate()-style pre-allocation on the write path:

1. Pre-allocate space on the server before writing to the page cache,
   analogous to fallocate() on the write path. This guarantees server-side
   space for page cache data.

2. Since per-write fallocate() calls require a server round-trip, effective=
ly
   negating the benefit of buffered I/O. Use cached statfs() output to gate
   when pre-allocation is triggered. For example, once free space drops bel=
ow
   20% of total space, enable fallocate() on the write path. Otherwise, let
   writes proceed as normal.

3. Handle refresh and synchronization of the cached statfs() data separately
   to avoid staleness.

I'd appreciate feedback from the community on viable approaches.

--
Regards,
Piyush
