Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238C4968E7
	for <netfs@lists.linux.dev>; Wed, 13 May 2026 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677877; cv=none; b=H/O2cqJsWUQ3ez97LJUJlpbdYm68CVY4saHJxa/BL64yiH3P30+318wv4s+Q4L7NtIzMkSyC/3Xfvyg5o85upePJ1cc629bpdbmSheExhdVfTvmMdKneLwHJQjhF3Qn3KDp88Ego3w+OiwmbRJ+tnIZ/P5ey/t9tiBAlBf0+HAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677877; c=relaxed/simple;
	bh=6FWAOdMRCGXRhuY+RZ6so9OqbtSfnT1i9cx1+5lpsns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aiCs9tQZHPsX6QgVdjvCJEgZnHGFg4R+27GTlfMvqFoUXeintQbSBI3F/ilQHVr0kRw02h06kGVeAdK9RbQB8De1kqU9YuKAFcX/RSl0cLxCmoDA+AENQ943ITqQMfkBj7rN4TGod/jfIVlx9TNoLRvh3zmMmv8jwPzTbSE/C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edQRMYbp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edQRMYbp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so3498154b3a.1
        for <netfs@lists.linux.dev>; Wed, 13 May 2026 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778677874; x=1779282674; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsFk6Og0o1PC9DlqH7Rg3d6wr5WjV/2ny+ljIhyfStU=;
        b=edQRMYbplClE92US9WYkzDlAYErfrr7tC/Am6jdu786brk4cHvRZzOuaKCEtzk+ylr
         ayOYx7sydkFkeECdOJIv0e/YtdNXGwxMsKwGS8rA02Us06y23mwolNkWH3wQ8okqloAQ
         mURePQUpwpX3awQmkXhbE8IsYSX0VB95jZbUdKWqbnoFdH/2X3h7WhJ36Liyy7VyKyCc
         XGerGnIxWZrUyFEGb0MqEz1ZLf/SlndgEYauwDp8JR/JdUQ4khAncPJQ1FLC+rGBFeSc
         G89RJIQhSWzwng3NNxTiA3bwui4eJo1utk/Aua/hquuuLW9nrhuRZEhOM7ycy2NPq1fd
         CDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677874; x=1779282674;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wsFk6Og0o1PC9DlqH7Rg3d6wr5WjV/2ny+ljIhyfStU=;
        b=hZp6VTc6lCI/+E9sfsZ2XbC/9roaqk8DcIANcjX+YMG4HCUo/uOL2GVqAihTAIPaGN
         fDX43SkKrSBYSNTIsaLMH9T7Ugc6NZCry1c5MB4qeYQJC0Mtathsyq//QEYeRHiU7H/+
         NDV9q59aDND0uMJqsIHCGQJYIplM8QZwFzfKIcaieQumQYew9W8Qy1c6/AsiDWPTSiMm
         /udNxRQn902z2aah7PIXpbuvv/iYKPXtqE/IULv8eecy1iFZmfRwBlwgATY9kA7y9B89
         Vs2GbuILi/O89b6dkz6fuztT9+xoLWy4X0Teqi1VQZOsXne9rRDLgXfSBKBMaGcWht1w
         JdAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HszaQp89jyYvVqd1gUYurC3jvF7Hxd7SdpQlEahGIJPMudzhMn6T4Xlvg9ymyfsDwTBF2aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOweGxQulU3eoK09n9KYAK+Lg6QBMaORMuWLHwt7zxyq3LmFhL
	DmPY7SjL8PmF+2CIgaprpgt/fA95S0749t8VqGC0cqmqTIPn7tXKuGW1
X-Gm-Gg: Acq92OGme8wwrhBCx8mHYo8AExZgrl6vir8rw8T4BvVLy86giKqPM3Eyhh+crke4hY8
	cCH2gfa5ZcZowntQLrGCIgSC7lxx/viUbB0k1pyGy3+L5MKzTdNCgISnDJ/atzb11Wm0hBp+qfe
	+iohS94KfeW0WyAUz+XP5DWKrw2FVGIe/WkWiUNsn0MebY+2eTPPwrB96W8AAeGBojOW3zjwD9W
	H2fjCBe42e/9YlysZYkPziYbVUrzLbPkaRWYctQo9BmVsJmFp1hPkEEeGL+MZbRlFjtmSCOPAgJ
	YxvM5OMgO5Cmx6Km8G9LpD096N+ijrGX3kcIaTHZQEKeHJWLbIGNkVbJOsQHBFpAuphZW+oEMVp
	pWocfIgxWFoNHO/7dbLTMWKKqJ8yGEWVcdrmG8quGHplraFEwiIliDT9rk91hJw06shta4h+Ppq
	BCmiFAcIV4oQ2xtBeE/Gsgmb9q0GZzSLxjcd7Q++g=
X-Received: by 2002:a05:6a00:3692:b0:82f:7cb7:63c7 with SMTP id d2e1a72fcca58-83ee8321af5mr6868969b3a.11.1778677874347;
        Wed, 13 May 2026 06:11:14 -0700 (PDT)
Received: from localhost ([49.207.149.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm26237472b3a.18.2026.05.13.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:11:13 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev
Cc: sprasad@microsoft.com, linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: [DISCUSSION] Preventing ENOSPC/EDQUOT writeback errors on
 network filesystems
In-Reply-To: <9e48229614786e0c2e92bb6a2dd3269868f160d0.camel@kernel.org>
References: <m21pfqgzbq.fsf@gmail.com>
 <9e48229614786e0c2e92bb6a2dd3269868f160d0.camel@kernel.org>
Date: Wed, 13 May 2026 18:41:10 +0530
Message-ID: <m2zf23e9ox.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Layton <jlayton@kernel.org> writes:

> On Tue, 2026-05-05 at 11:41 +0530, Piyush Sachdeva wrote:
>> Hi,
>> There have been plenty of discussions on how to handle writeback errors =
for
>> network filesystems, but most have focused on error reporting after the =
fact.
>> I'd like to start a discussion around preventing writeback errors specif=
ically
>> ENOSPC and EDQUOT, before they cause silent data loss.
>>=20
>> The problem:
>> With buffered writes on network filesystems (cifs, nfs, etc.), the write=
()
>> syscall copies data into the page cache and returns success immediately.=
 The
>> actual upload to the server happens later during writeback. If the serve=
r is
>> out of space at that point, the write fails with ENOSPC. The netfs/write=
back
>> layer records this error via mapping_set_error(), but critically the fol=
io's
>> writeback flag is cleared and the page is now clean. Under memory pressu=
re, the
>> VM can reclaim these clean pages, permanently losing data that the appli=
cation
>> believes was successfully written. Meanwhile, i_size has already been up=
dated
>> to reflect the new file size. So stat() shows a file size inclusive of t=
he data
>> that was never persisted. Another inconsistency here is that total free =
space
>> hasn't been modified for the file system on the server, leading to incor=
rect
>> values in statfs() output from the client's pov (assuming statfs() calls=
 go
>> to the server).
>> To illustrate with real-world scenarios:
>>=20
>> - A user or application can keep issuing writes to an fd well beyond the
>>   available space, since buffered writes return success as soon as data =
is
>>   copied to the page cache. A significant amount of data, exceeding the
>>   available quota can accumulate before fsync() is called, at which point
>>   critical data loss is nearly certain.
>>=20
>> - A malicious user can exploit this to keep resources pinned and memory
>>   oversubscribed, impacting other applications.
>>=20
>> The error is technically observable: fsync() will return it, and close()
>> surfaces it through the flush callback. But in practice, many applicatio=
ns
>> check neither, and the POSIX "just call fsync()" answer isn't satisfying=
 for
>> users who lose data silently.
>>=20
>
> Yet, it is the only real answer we have.
>
> This is just a fundamental issue with buffered writes and delayed
> writeback. Either you flush the data to stable storage now, or you have
> to do it later. If you do it later, then it can still fail for all
> sorts of reasons.
>
>> Local filesystems largely avoid this because they can check available sp=
ace
>> synchronously in write_begin() and fail the write() syscall directly. Ne=
twork
>> filesystems can't do this cheaply =E2=80=94 a round-trip per write to ch=
eck server
>> space would negate the benefits of buffered I/O.
>>=20
>> Through recent development, netfs is becoming a central layer for network
>> filesystem I/O. It already has retry logic for transient failures (EAGAI=
N,
>> ECONNABORTED), but ENOSPC/EDQUOT remain hard failures. This affects every
>> network filesystem using buffered writes.
>>=20
>> I am curious to know if NFS has a solution to this and what the approach=
 is
>> towards this specific problem by NFS community?
>>=20
>> This problem is worth solving for all network filesystems. I have a few
>> thoughts on approaches, combining cached statfs() output with
>> fallocate()-style pre-allocation on the write path:
>>=20
>> 1. Pre-allocate space on the server before writing to the page cache,
>>    analogous to fallocate() on the write path. This guarantees server-si=
de
>>    space for page cache data.
>>=20
>> 2. Since per-write fallocate() calls require a server round-trip, effect=
ively
>>    negating the benefit of buffered I/O. Use cached statfs() output to g=
ate
>>    when pre-allocation is triggered. For example, once free space drops =
below
>>    20% of total space, enable fallocate() on the write path. Otherwise, =
let
>>    writes proceed as normal.
>>=20
>> 3. Handle refresh and synchronization of the cached statfs() data separa=
tely
>>    to avoid staleness.
>>=20
>> I'd appreciate feedback from the community on viable approaches.
>
> NFSv4.2 does have an ALLOCATE operation:
>
>     https://datatracker.ietf.org/doc/html/rfc7862#section-15.1
>
> ...and such an operation could (in principle) precede WRITE in a
> compound, but that doesn't really help you. By the time we're issuing
> RPCs to the server, the client application has already finished its
> writes and moved on.
>
> For applications that want to avoid ENOSPC/EDQUOT, the best thing they
> could do is call fallocate() themselves to ensure that the space
> exists. With a sufficiently recent NFS client and server, that should
> DTRT.

Hey Jeff,
Thanks for your email and for sharing the NFS spec. I noticed that the
ALLOCATE operation ends up checking for space during write-back as well,
and the initial concern of loosing data still remain. But if we do the
operation before writing to the page-cache, it would be a performance
issue.

I will try a few experiments and then post my findings here.=20

--
Regards,
Piyush
