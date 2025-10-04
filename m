Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E661F5E6
	for <netfs@lists.linux.dev>; Sat,  4 Oct 2025 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552412; cv=none; b=TTQX0JJToExWiXw+0EWd0KQ0MvYF5KIR6Y4fZUmosqd8Boj5tceSqGfoxT5kUdW/+PjODTj2Sbe9pbN8LGMCvW+tz8niKkFVykjZW5AU76tZZbWxeAmGK2kvWltusqZ4l5GRCjIdmdzdwFYH1EEZJYUqzC5wJyAknnV8MF2CfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552412; c=relaxed/simple;
	bh=Df+P6JYS2QqpJ3w//ROe66heiGBWOhpaPg4cAlSuCkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L47uEyHEaXUCHMJhv4FWOzAm7fKWYNWO6KtebZu3syny9f2X8D4wXgvN1IQ5btZbLV2162n+7qKb1dNHmNL8jgQBhjdz7G5MmlicAtN5diMUT/VFxJV5ySKJTrkTJy4iiaNUILKUTClKrTWgxBou6ok/1cWMosaQ+a70tBQU8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcYmyN3N; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcYmyN3N"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso2178768b3a.2
        for <netfs@lists.linux.dev>; Fri, 03 Oct 2025 21:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759552410; x=1760157210; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrHxtAEC7jf6mOF6GS8lZ4qi3Xoaj0BUwdJ6rxR1K5s=;
        b=NcYmyN3N2MDn9N8ro/NyUuW7U3mu9cMAH9vLWSMlYpncMIU8DvnjsrT4eKTat6ls9T
         VEjeEtqM5qiDKcFy+2wt5leS5pfIWK6UgvP0d2Yw5s+6eWzRjRg9xYkW/b5eLEkZp0Tx
         kJN3W2Kqg33TRYkMjpJ/DT+5JalZ3DiRvXpYepSxug5+WDw1LY7H8mnP57YC1ZIJk2F0
         lG55DwgzOEeA/DayxgpPrvyPEEWO0pDLsnbt1CXLqhMARBLGDC8dDmC0h4ZYq6+0OrS4
         NeQEZ/8YALcwG2tp0xQ9rsAAF0aRtb3Opr5oBY6I/1GBSM3NkWOGbJpFQis2x3U6SBNN
         zrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759552410; x=1760157210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrHxtAEC7jf6mOF6GS8lZ4qi3Xoaj0BUwdJ6rxR1K5s=;
        b=Gh24i22TyMzKstxuU5aKUb74ybD/jkhRmU5AzZcFg46k4AtPknOiIp0SJ8GOuOxfzc
         x4FbsibZK2Lsrb99NTfXYal8z0ukeC4vWffsjxP1kP0rOqK4FHp2ihjiJjo1yE8vMpYr
         hmuimRFkmut718qXtRLsyO0NwHQCTR7kywfWRIWPQwqEXdRkbpL3zz8slo+eTu78UXjc
         xUc2lyjO6sKgzVDzvrQ7LO5wEXpuum/mWu2SO4Pm6Xf8EdSHUWcbrHdBGZfXOTu9WhiC
         BvFLMAHGuI7qon81bLsr4ssagzA0e+oyCpwM+DxDcq4EXoGKdBcS13sMFEHNeCw6D3wW
         Ifng==
X-Forwarded-Encrypted: i=1; AJvYcCWF0JbYedFMtv93d8fgF3SdtVV4eOld4UoXxEUrI6X/cbGKIXj1ZVA0ndSzmUPz6MF0dP9zcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpsbGCsGTQtxKCb1xzLu034lnnmcsm/6E2NZwFNMB7bc8xdSi/
	G7DJLN3cccGXDNTUCDJYQtjLMM/4nGK496XRtmcC/tx3WZMnEE6aQuSx
X-Gm-Gg: ASbGncuRw2bMYLAkfsdPtUF2qMMmGde2wDKhOmHVC120cujakIrm6oTC8xARbWq+qHD
	ertxi3oO0ca3SDOutg2z1Kx3BVMy5mTRz31fSlP72uW/l592oK4TQ4Bm12xuDL1Fd2n3Fl5DSrl
	OqFWl9QwhekIs7uYtOyMavW8DdUTc3fp8c5FN9Mg/vkGAUMvY5+cmgzVF2pMDqKC95BiXLeLKI2
	uKptR5/G6i4KZQpvMF7RBVu8dTyNBckpk9b//wYdPw84CoAb+Gpl6W8vnBFem92lan/lB0jJmDR
	PcpO50uDPV468JpLQdX+lw0BNvHE/IT0Wz3LoXA1vDEUclFTDWsRkojnp5597s/5c/pOF1O3tvJ
	/9OIGQXlhEhHhBZh0CqyorvXR6KA2xZUT7i5g7WnrZJSoXFfeaGn8FLST9Rhig7Ukf16pczc=
X-Google-Smtp-Source: AGHT+IGNRTvBKcRxRWDiko/GbUAC7KjssTgPw+LYSnL0AkNM1865qmWf8lHSyAxiS9XfPYucFzzf3w==
X-Received: by 2002:a05:6a20:7291:b0:251:a106:d96c with SMTP id adf61e73a8af0-32b61dff63fmr7315477637.10.1759552410455;
        Fri, 03 Oct 2025 21:33:30 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.90.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099add13esm6086455a12.8.2025.10.03.21.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 21:33:30 -0700 (PDT)
Message-ID: <a87756f6-b578-421e-b04b-b1dd15f3a2f1@gmail.com>
Date: Sat, 4 Oct 2025 10:03:22 +0530
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: doc: Fix typos
To: Carlos Maiolino <cem@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-bcachefs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <DrG_H24-pk-ha8vkOEHoZYVXyMFA60c_g4l7cZX4Z7lnKQIM4FjdI_qS-UIpFxa-t7T_JDAOSqKjew7M0wmYYw==@protonmail.internalid>
 <20251001083931.44528-1-bhanuseshukumar@gmail.com>
 <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 17:32, Carlos Maiolino wrote:
> On Wed, Oct 01, 2025 at 02:09:31PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> Fix typos in doc comments
>>
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> 
> Perhaps would be better to split this into subsystem-specific patches?
> 
> This probably needs to be re-sent anyway as bcachefs was removed from
> mainline.
> 
> 
>> ---
>>  Note: No change in functionality intended.
>>
>>  Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
>>  Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
>>  fs/netfs/buffered_read.c                                 | 2 +-
>>  fs/xfs/xfs_linux.h                                       | 2 +-
>>  include/linux/fs.h                                       | 4 ++--
>>  5 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/filesystems/bcachefs/future/idle_work.rst b/Documentation/filesystems/bcachefs/future/idle_work.rst
>> index 59a332509dcd..f1202113dde0 100644
>> --- a/Documentation/filesystems/bcachefs/future/idle_work.rst
>> +++ b/Documentation/filesystems/bcachefs/future/idle_work.rst
>> @@ -11,10 +11,10 @@ idle" so the system can go to sleep. We don't want to be dribbling out
>>  background work while the system should be idle.
>>
>>  The complicating factor is that there are a number of background tasks, which
>> -form a heirarchy (or a digraph, depending on how you divide it up) - one
>> +form a hierarchy (or a digraph, depending on how you divide it up) - one
>>  background task may generate work for another.
>>
>> -Thus proper idle detection needs to model this heirarchy.
>> +Thus proper idle detection needs to model this hierarchy.
>>
>>  - Foreground writes
>>  - Page cache writeback
>> @@ -51,7 +51,7 @@ IDLE REGIME
>>  When the system becomes idle, we should start flushing our pending work
>>  quicker so the system can go to sleep.
>>
>> -Note that the definition of "idle" depends on where in the heirarchy a task
>> +Note that the definition of "idle" depends on where in the hierarchy a task
>>  is - a task should start flushing work more quickly when the task above it has
>>  stopped generating new work.
>>
>> diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
>> index e231d127cd40..e872d480691b 100644
>> --- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
>> +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
>> @@ -4179,7 +4179,7 @@ When the exchange is initiated, the sequence of operations is as follows:
>>     This will be discussed in more detail in subsequent sections.
>>
>>  If the filesystem goes down in the middle of an operation, log recovery will
>> -find the most recent unfinished maping exchange log intent item and restart
>> +find the most recent unfinished mapping exchange log intent item and restart
>>  from there.
>>  This is how atomic file mapping exchanges guarantees that an outside observer
>>  will either see the old broken structure or the new one, and never a mismash of
>> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
>> index 37ab6f28b5ad..c81be6390309 100644
>> --- a/fs/netfs/buffered_read.c
>> +++ b/fs/netfs/buffered_read.c
>> @@ -329,7 +329,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
>>   * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
>>   * requests from different sources will get munged together.  If necessary, the
>>   * readahead window can be expanded in either direction to a more convenient
>> - * alighment for RPC efficiency or to make storage in the cache feasible.
>> + * alignment for RPC efficiency or to make storage in the cache feasible.
>>   *
>>   * The calling netfs must initialise a netfs context contiguous to the vfs
>>   * inode before calling this.
>> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
>> index 9a2221b4aa21..fdf3cd8c4d19 100644
>> --- a/fs/xfs/xfs_linux.h
>> +++ b/fs/xfs/xfs_linux.h
>> @@ -145,7 +145,7 @@ static inline void delay(long ticks)
>>  /*
>>   * XFS wrapper structure for sysfs support. It depends on external data
>>   * structures and is embedded in various internal data structures to implement
>> - * the XFS sysfs object heirarchy. Define it here for broad access throughout
>> + * the XFS sysfs object hierarchy. Define it here for broad access throughout
>>   * the codebase.
>>   */
>>  struct xfs_kobj {
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 601d036a6c78..72e82a4a0bbc 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1040,7 +1040,7 @@ struct fown_struct {
>>   * struct file_ra_state - Track a file's readahead state.
>>   * @start: Where the most recent readahead started.
>>   * @size: Number of pages read in the most recent readahead.
>> - * @async_size: Numer of pages that were/are not needed immediately
>> + * @async_size: Number of pages that were/are not needed immediately
>>   *      and so were/are genuinely "ahead".  Start next readahead when
>>   *      the first of these pages is accessed.
>>   * @ra_pages: Maximum size of a readahead request, copied from the bdi.
>> @@ -3149,7 +3149,7 @@ static inline void kiocb_start_write(struct kiocb *iocb)
>>
>>  /**
>>   * kiocb_end_write - drop write access to a superblock after async file io
>> - * @iocb: the io context we sumbitted the write with
>> + * @iocb: the io context we submitted the write with
>>   *
>>   * Should be matched with a call to kiocb_start_write().
>>   */
>> --
>> 2.34.1
>>
Hi,

Thanks for pointing out the fact that the bcachefs is now externally maintained.

I will exclude it in my future versions and will split the patch in to subsystem specific.

Regards,
Bhanu Seshu Kumar Valluri
