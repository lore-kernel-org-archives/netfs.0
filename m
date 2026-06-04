Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39E3D47AE
	for <netfs@lists.linux.dev>; Thu,  4 Jun 2026 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555897; cv=none; b=oBO9xeUFqUAeMI3Z/T1sD1GUQA8jXEDb+3ODAMCBby6ZorXYtJz/AeLa0EDeAt7bc8h5C3WaUiZ7U3DohK/kCftaNCjzgaR7xNuBVG0mNFIgyqCjbt0ykZqfUTPgN4nm1DwICzClEsoyQhChHKJdkiXGbv0d+CimMEjfzcX+rL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555897; c=relaxed/simple;
	bh=rZfmT8E2vEREwINMSsmZrCaMt9v4llL/bgylmcTIXuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESQtiGWgvxzdcFoISB1Z6vk0T9eU8R047tkmzJPTvXeZNMZhzMjyD2/M9AnF642qbVZOl7YkCuAfpvZbhO1u9gxRYLtBbGMr8xz/5VcQMRinJmGwqNRJWYf64mbdKhPIcIO75iDm9B747gcqJdIUcgldXPEkjh64LMKqsH3pHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oggB1O7Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oggB1O7Z"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso3804795ad.0
        for <netfs@lists.linux.dev>; Wed, 03 Jun 2026 23:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780555895; x=1781160695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9uqJ9zIvGX0NDqn7gTsRWpyFlMlfqGeCbba9ggEOAI=;
        b=oggB1O7ZFl9qPw4a3xUNKYbJy5TDBdee/SHNjpc0ZIjeKN+VdwyNJV0fG54IeQEGg5
         vgXXDEPdQQKqSdHLOhgyYFBUtmpZcBNyw1ywORk9d+kNIEjfbtRUVlArnneCEllbucFu
         IThD/JineSG9WQVxJSSSDPTYAxDfqTZi8FxFyD9kUzJgqaXrJRzJgPPpQKMPWU1iJN26
         HIbu8kF6028DQpqwDqefNfJ96kiezRnSOxrURKskeDN/OWSg9niX7Ym9zAcrGQUn+Tgy
         xQoA8MWWM8iOVMGmzKS4kOpdqvieFLfVj+CaoZ9odpqUbk1gA29823g/+Sth5LiJ11o6
         nxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555895; x=1781160695;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9uqJ9zIvGX0NDqn7gTsRWpyFlMlfqGeCbba9ggEOAI=;
        b=F8V2pefE/thN/OwS/y5y7k+SwzFOG2QK7oIRtP3rDRAH6EPRPqZJVANC3AJ/mCrvc8
         2+Kp5Hec3yguyjZ4BZEORE/aA3k7YD35XkZLetIq452156VqsycwFab3bMsYm2NxM6vB
         J79MVpW9IQChJVPmnqofJgkoge/1j67xyh6iIIhNv4cnzFDug8ogu4D16V6doJVjGctY
         NtmXI0EeX5nNGNOfjvtuAHOK5Tb5h/GrRwPqGXLp6efgv4rIrFcsrh8l49G9Rsi5LaVU
         EAcKSP0OzCP6oL2WzMokFbvCXy+jCLl/Ow8hO7zmq6XfdSjboAPLvZMUVEC6fFOfVajG
         InKw==
X-Forwarded-Encrypted: i=1; AFNElJ+4WhLYOHQ0SokGz5kobbFo1QkOLoQou3CJhHt3Z/QEW9I62em6KGHjxntAtX5YTDDBwRq/lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU3ZNAsedO+Stbebx4WBzDlmgT7aCm/AXj00Wh22v5y0NYssXH
	Mga+gULHIyC+vJRIfM7KTX2eJg72mWXXajmmDkvbF2OxkncR6uHP6QOXlrNE4w==
X-Gm-Gg: Acq92OHWGrOGaTwVsz1evhFY0Xv/xgYAgRr3spw4nHBqCgTra3EnLOdzGuf82sbhUuQ
	mew6z85Wd78Nt+NI9p5jWqZekCfR6K7DF/xpiFJBjm8DuC5jXOWIiEAuEaa792gHhL3A6Yq1p51
	j2hQlcMExhvQsqA8g/COSmgUdXqW3aHiI6qq4o5i2yJvdJRtX6jE0mvynRlqjKUHaNm0Yv7M46+
	Jwz9+w7PvrevW7GHEkS5fwLalFLHsT9xZrBGVC8arGGxNqvm9Ws6zfadkb5ExsD6jsW3rzwVBt0
	ReVRZlgNh66w00CB8Xttn/Y66QbZadNMvXbRPOZkVfp1/dFKyToSeSJqxz5LbgwU5rVWjXAoTUu
	Aot/irqCeY5PhiiHnZB6p8ZB1+ZdV/PmzDVw70dP0arRVzNh3rKQECzGwM7ClyFqmtsQ6cw9zFy
	ju7AivS0O/ttm1MllTVnFxPOnaiippt840DvruY+qza8YmgFm7
X-Received: by 2002:a17:903:808:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2c1644dd0aamr41901955ad.40.1780555894693;
        Wed, 03 Jun 2026 23:51:34 -0700 (PDT)
Received: from localhost ([49.207.144.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e573sm46972795ad.47.2026.06.03.23.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:51:34 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev
Cc: sprasad@microsoft.com, linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: [DISCUSSION] Preventing ENOSPC/EDQUOT writeback errors on
 network filesystems
In-Reply-To: <m2zf23e9ox.fsf@gmail.com>
References: <m21pfqgzbq.fsf@gmail.com>
 <9e48229614786e0c2e92bb6a2dd3269868f160d0.camel@kernel.org>
 <m2zf23e9ox.fsf@gmail.com>
Date: Thu, 04 Jun 2026 12:20:45 +0530
Message-ID: <m2tsribxyy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Piyush Sachdeva <s.piyush1024@gmail.com> writes:

> Jeff Layton <jlayton@kernel.org> writes:
>
>> On Tue, 2026-05-05 at 11:41 +0530, Piyush Sachdeva wrote:
>>> Hi,
>>> There have been plenty of discussions on how to handle writeback errors=
 for
>>> network filesystems, but most have focused on error reporting after the=
 fact.
>>> I'd like to start a discussion around preventing writeback errors speci=
fically
>>> ENOSPC and EDQUOT, before they cause silent data loss.
>>>=20
>>> The problem:
>>> With buffered writes on network filesystems (cifs, nfs, etc.), the writ=
e()
>>> syscall copies data into the page cache and returns success immediately=
. The
>>> actual upload to the server happens later during writeback. If the serv=
er is
>>> out of space at that point, the write fails with ENOSPC. The netfs/writ=
eback
>>> layer records this error via mapping_set_error(), but critically the fo=
lio's
>>> writeback flag is cleared and the page is now clean. Under memory press=
ure, the
>>> VM can reclaim these clean pages, permanently losing data that the appl=
ication
>>> believes was successfully written. Meanwhile, i_size has already been u=
pdated
>>> to reflect the new file size. So stat() shows a file size inclusive of =
the data
>>> that was never persisted. Another inconsistency here is that total free=
 space
>>> hasn't been modified for the file system on the server, leading to inco=
rrect
>>> values in statfs() output from the client's pov (assuming statfs() call=
s go
>>> to the server).
>>> To illustrate with real-world scenarios:
>>>=20
>>> - A user or application can keep issuing writes to an fd well beyond the
>>>   available space, since buffered writes return success as soon as data=
 is
>>>   copied to the page cache. A significant amount of data, exceeding the
>>>   available quota can accumulate before fsync() is called, at which poi=
nt
>>>   critical data loss is nearly certain.
>>>=20
>>> - A malicious user can exploit this to keep resources pinned and memory
>>>   oversubscribed, impacting other applications.
>>>=20
>>> The error is technically observable: fsync() will return it, and close()
>>> surfaces it through the flush callback. But in practice, many applicati=
ons
>>> check neither, and the POSIX "just call fsync()" answer isn't satisfyin=
g for
>>> users who lose data silently.
>>>=20
>>
>> Yet, it is the only real answer we have.
>>
>> This is just a fundamental issue with buffered writes and delayed
>> writeback. Either you flush the data to stable storage now, or you have
>> to do it later. If you do it later, then it can still fail for all
>> sorts of reasons.
>>
>>> Local filesystems largely avoid this because they can check available s=
pace
>>> synchronously in write_begin() and fail the write() syscall directly. N=
etwork
>>> filesystems can't do this cheaply =E2=80=94 a round-trip per write to c=
heck server
>>> space would negate the benefits of buffered I/O.
>>>=20
>>> Through recent development, netfs is becoming a central layer for netwo=
rk
>>> filesystem I/O. It already has retry logic for transient failures (EAGA=
IN,
>>> ECONNABORTED), but ENOSPC/EDQUOT remain hard failures. This affects eve=
ry
>>> network filesystem using buffered writes.
>>>=20
>>> I am curious to know if NFS has a solution to this and what the approac=
h is
>>> towards this specific problem by NFS community?
>>>=20
>>> This problem is worth solving for all network filesystems. I have a few
>>> thoughts on approaches, combining cached statfs() output with
>>> fallocate()-style pre-allocation on the write path:
>>>=20
>>> 1. Pre-allocate space on the server before writing to the page cache,
>>>    analogous to fallocate() on the write path. This guarantees server-s=
ide
>>>    space for page cache data.
>>>=20
>>> 2. Since per-write fallocate() calls require a server round-trip, effec=
tively
>>>    negating the benefit of buffered I/O. Use cached statfs() output to =
gate
>>>    when pre-allocation is triggered. For example, once free space drops=
 below
>>>    20% of total space, enable fallocate() on the write path. Otherwise,=
 let
>>>    writes proceed as normal.
>>>=20
>>> 3. Handle refresh and synchronization of the cached statfs() data separ=
ately
>>>    to avoid staleness.
>>>=20
>>> I'd appreciate feedback from the community on viable approaches.
>>
>> NFSv4.2 does have an ALLOCATE operation:
>>
>>     https://datatracker.ietf.org/doc/html/rfc7862#section-15.1
>>
>> ...and such an operation could (in principle) precede WRITE in a
>> compound, but that doesn't really help you. By the time we're issuing
>> RPCs to the server, the client application has already finished its
>> writes and moved on.
>>
>> For applications that want to avoid ENOSPC/EDQUOT, the best thing they
>> could do is call fallocate() themselves to ensure that the space
>> exists. With a sufficiently recent NFS client and server, that should
>> DTRT.
>
> Hey Jeff,
> Thanks for your email and for sharing the NFS spec. I noticed that the
> ALLOCATE operation ends up checking for space during write-back as well,
> and the initial concern of loosing data still remain. But if we do the
> operation before writing to the page-cache, it would be a performance
> issue.
>
> I will try a few experiments and then post my findings here.=20
>
> --
> Regards,
> Piyush

Hi,
While running experiments, I came across an interesting finding.

Context:
When writing data beyond the available space/quota on the server, we
don't expect to receive an error on write immediately, given its a
buffered write. The EDQUOT/ENOSPC error surfaces on a call to fsync(2),
either directly, or implicitly via close(2). CAVEAT: close(2), doesn't
guarantee a flush of data to the backing store.

Finding:
When the flush of over-flowed data - sitting in the pagecache is tried
using a fsync(2) call, we expect it to fail. However, it looks like that
the NetFS layer, used by the SMB client to do the writeback, doesn't
re-set the dirty bit on the pages/folios on which fsync fails. At this
point the pages with critical user-data are sitting in the pagecache,
but no longer marked dirty/referenced by the inode of the file. This
behavior is seen for EDQUOT/ENOSPC errors, contrary to EIO errors where
data is re-dirtied. It seems that EDQUOT/ENOSPC are treated as
non-retriable errors, as a reason the dirty bit is not re-set.
I noticed that NFS also has a similar behavior where the pages are not
dirty after the failed fsync. Naturally, now that the fsync is
tried before calling close, and with the data not-dirty anymore, no
errors are seen on close.

While, the close(2) manpage explicitly states that upon failure, close
should not be retired, I do believe that the data should still remain
dirty. An application (should) calling fsync before close would monitor
for errors, and should be able to retry the fsync after increasing the
capacity on the server.

I would appreciate thoughts on my idea.=20

--=20
Regards,
Piyush
