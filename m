Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643418DF6F;
	Tue, 20 Aug 2024 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159029; cv=none; b=DMgJGRctztZP/Z0GRxA1/5HWOnCwXzo9QWTz/4MQ3McypE1LbVm/MpIkV4xpH0gEAm+WBGwKkPNRazekAPYMqrvy4rvaH7wGbcxw/VbTXIV6MV4YFPfHkyt+K+ObsUsjAwzGE6uSkcbXQoTaZ0+q6RfXG5eYey5bVFgaOCbeW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159029; c=relaxed/simple;
	bh=w6hRjDJ3yafIcbZnpdNQYFv3oHEqNh6DZlxKaKdRU8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzZYTRpkBNNJKG3hXhwc86nbLngoquE/bo9usZD4Hy8xUqERyCCG94AqPNpDzu9WyRXUH2IyUfbV1SUHx8p7IlhYk6M81J8VnZWkni21fBy4pbrKmLLDkED6h2ALKVMXU27HvtZv4hP5neIYakBgiM31ipOJoxcCuLW8zoc02Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Thx34V12; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thx34V12"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04c29588so7361450e87.3;
        Tue, 20 Aug 2024 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724159026; x=1724763826; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awAU/8j1nfeNdkyYYcksFXZ+w3rbcsEiJfjnpMbgCt4=;
        b=Thx34V12kY5cACvlvsaokRPaXqfTw1e4lk8kmJ/TwEfgL8nXSVGRJW+a47uVFqxpWO
         15QZmn6rjgGkGlKqqOa+6J3DV6/D4IRqxT/sRfPFvvQRRtOk4/SY+ldv2Frn94KzPm8v
         3xf32IuqRjNG6QDBmikTqBTymMZnO3z0jKC42cmf7tvhdNc0jIHufV/pSgSPASyFGTV1
         4ME1s15wDBDtFtzNgmopOSLWxBlf26rAJbFpSj0HHDhROA/kEYNB/mt8nOVLxqOdjLOK
         QBK6BSuClO4fGwtZPr1NuAhnB19WY1DZuBdgj5bnl7Y2pX667dPMZ3iLjMxO7Oas+a4Z
         P1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724159026; x=1724763826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awAU/8j1nfeNdkyYYcksFXZ+w3rbcsEiJfjnpMbgCt4=;
        b=X081NtLk+VFylxAU5M6tZ30MKzrtsVrT1l3XQ9uiSAsTe1BiuOMM+ZdsvcwfTwb+y6
         7x25RfMsd/vrmD0/cEWvsQ24/tRmXQm4z7+fr90LrcYG9/Uhe+a83R0wOLEpc1abzxi6
         MjPZSkKreaCupucCk2Tm7Dn0oLwwpQ0q6T0huWMEbrcMbCvgp7FHXp+4PaZptGVp8wa3
         KXOYa3Osu8bN56/7zxvsRJH2ZV36NI5CwrD8IxGmw5pw2DdiFyMmpGNNyJO9i3B3dmHm
         LshWuV0sJW8xU/9+77brPouaQOaINImf7g/RdrwwRWzwUum2+FsxR5Y7uPeNursmm3yp
         CqkA==
X-Forwarded-Encrypted: i=1; AJvYcCUMCcqS1vEsnScuAwaAMHuL+At25ioGuM8uqZl2BEy8sZtA3zzU8lCY63EbAU4R3e0B9DEaXhXP@lists.linux.dev, AJvYcCUbqlxwdewkUyLhxzCwNRYB2MRUEKaOn17+VlGBpPkkRXBU7CzbV+FDFK1WnuwlTfDePBz+YQ==@lists.linux.dev, AJvYcCXdYIfL+yeyAPBbmTn4BPBNRjjCOXf6TF6ggSG0bYonOW96/dH2RZ8PpUEBXhVwl+/ijAT4xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrO5WotscWHeahm+StL0mJY9kP/jel0SUShHJYDLiM+uI00mGE
	FcN/zqb4Z/dcegTbd/CZUkQS+hTVgVjFqXqVe6cTMaaegOluRMIZKw5EhtzjA0xN+V6osCJeQ97
	kpy/5Vj9fY/xdwy/vofVEevkKxMDeSg==
X-Google-Smtp-Source: AGHT+IE5G7lBUkb59Tw6MSWX1/GxCWDgjFEGErERFXVC5Rbunu+hdmsvVYYihhwM4SHPcVX7CL91YlwOrwKcBjYHKFM=
X-Received: by 2002:a05:6512:6ce:b0:52f:d0f0:e37e with SMTP id
 2adb3069b0e04-5331c6dca58mr9000627e87.42.1724159025365; Tue, 20 Aug 2024
 06:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <202408201441.9e7177d2-oliver.sang@intel.com>
In-Reply-To: <202408201441.9e7177d2-oliver.sang@intel.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 20 Aug 2024 08:03:34 -0500
Message-ID: <CAH2r5ms-jpA5-h2EtgLb82D1hYboaKU3P4W=7_22zRd_gQK_Cw@mail.gmail.com>
Subject: Re: [linus:master] [9p] e3786b29c5: xfstests.generic.465.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, v9fs@lists.linux.dev, 
	linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes - I can also reproduce this regression on generic/465 and at least
two other xfstests (works with that patch removed)

On Tue, Aug 20, 2024 at 2:08=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "xfstests.generic.465.fail" on:
>
> commit: e3786b29c54cdae3490b07180a54e2461f42144c ("9p: Fix DIO read throu=
gh netfs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: xfstests
> version: xfstests-x86_64-f5ada754-1_20240812
> with following parameters:
>
>         disk: 4HDD
>         fs: ext4
>         fs2: smbv3
>         test: generic-465
>
>
>
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake)=
 with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408201441.9e7177d2-oliver.san=
g@intel.com
>
> 2024-08-17 02:14:44 mount /dev/sda1 /fs/sda1
> 2024-08-17 02:14:44 mkdir -p /smbv3//cifs/sda1
> 2024-08-17 02:14:44 export FSTYP=3Dcifs
> 2024-08-17 02:14:44 export TEST_DEV=3D//localhost/fs/sda1
> 2024-08-17 02:14:44 export TEST_DIR=3D/smbv3//cifs/sda1
> 2024-08-17 02:14:44 export CIFS_MOUNT_OPTIONS=3D-ousername=3Droot,passwor=
d=3Dpass,noperm,vers=3D3.0,mfsymlinks,actimeo=3D0
> 2024-08-17 02:14:44 echo generic/465
> 2024-08-17 02:14:44 ./check -E tests/cifs/exclude.incompatible-smb3.txt -=
E tests/cifs/exclude.very-slow.txt generic/465
> FSTYP         -- cifs
> PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.11.0-rc1-00012-ge3786b29c54c =
#1 SMP PREEMPT_DYNAMIC Fri Aug 16 01:36:30 CST 2024
>
> generic/465       - output mismatch (see /lkp/benchmarks/xfstests/results=
//generic/465.out.bad)
>     --- tests/generic/465.out   2024-08-12 20:11:27.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/465.out.bad   2024-08-1=
7 02:15:42.471144932 +0000
>     @@ -1,3 +1,597 @@
>      QA output created by 465
>      non-aio dio test
>     +read file: No data available
>     +read file: Invalid argument
>     +read file: No data available
>     +read file: Invalid argument
>     +read file: No data available
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/465.out /lkp/ben=
chmarks/xfstests/results//generic/465.out.bad'  to see the entire diff)
> Ran: generic/465
> Failures: generic/465
> Failed 1 of 1 tests
>
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240820/202408201441.9e7177d2-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>


--=20
Thanks,

Steve
