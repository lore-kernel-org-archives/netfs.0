Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEC14AD2B
	for <netfs@lists.linux.dev>; Mon,  6 Jan 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184210; cv=none; b=MOA5Ce1+CTCANANfTo46Rfm9N8bBHMlwY0qGQUc+C4jdxCkH0VO0vpOrfWJKi/wdtEeIA0K3S69FjdDeknwrgGpaZdaTdZxLDMRONRwCnc/RI272Zv/CCveoESiyokx/pbyZzDG4HzlhX9gqKu8hwv6lzJGmJOi57P7hZRf/klo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184210; c=relaxed/simple;
	bh=urHZ55AU7/h1ujpGW5V+Z2oQZ2zmoCNcJLo5BCPyeBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JevNUBUiUlOeFwmZGEIds56XRi4fAxta3CuozhnN4XgoKdRpxzhlLWFEhap+pp4qCp3tIFFuO9QjMSdEz/44/Kx54el0jyB/4sTYb3FYmy1AeF0rfuLXGGNlne7MziqeEq7BC8IEuOgVbRYjnLtzboeg+DfnHU6Ev2yxkyUK8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ9/A3Q9; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ9/A3Q9"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467b086e0easo74625791cf.1
        for <netfs@lists.linux.dev>; Mon, 06 Jan 2025 09:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736184207; x=1736789007; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urHZ55AU7/h1ujpGW5V+Z2oQZ2zmoCNcJLo5BCPyeBs=;
        b=WQ9/A3Q9KB4zuQxIcEt/pfisZnkN+92sNLrJbzIh5Q6PMZhn4q418HM2uYpz4rdVKH
         yacmRL9pFPc61/VWDa7YI9qEGQp1NOakd3LgGbrq23IvEUpRZiJ9Oy/YT1neybfOkUA3
         kKXUpVHCmoPgy+IxdTN+exh6e4g7kpJQynm2b8+L7ImJt4HFlUvGOW9ptbOP4kx4ziPU
         rH8cNjagjvyQ4aw+3lIjiZF7VQPHoV8L1Zu1VY+hrq+AIwX2a83nFdB3PDqYd5U9F1wP
         Xwr12DCChx3Ji9ix3BP5W9pfMZOl4XhfOT6PFsRolXzfzIKB8QcA/LzQ5r4Euc5zD+OU
         TdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736184207; x=1736789007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urHZ55AU7/h1ujpGW5V+Z2oQZ2zmoCNcJLo5BCPyeBs=;
        b=oH6gQMCl5cVDWY7SrrcOp2YZbrPn3U3AnJsGaDDL0kthcVGzY4OGLnHt8PYQD0YSMf
         dTNT0aKdKGMF8V0f8T3dhI4zlC72St1oPQRye2Nhtot+e0IpqxbAa8h2dmLjNngjmoiq
         45LqkFV3bdojL86pYuXJ7lhHijdN39wsrwjUsvfB8F8quhYAtZOj88fP71u5HkXFf6vr
         DNv+SnhRGP3x6XlfBuSYNuJCxSkrARm/0JuKXnGg8LAR8Ud87iCU9A/dJZK/8B7UsztP
         +suR0Drspw6FiKGXZkxO2sSyHa+OtJ/3jt1Q0bBrgw+YYHh5C+i5J0C/ji3T0rGYeaT7
         sftw==
X-Forwarded-Encrypted: i=1; AJvYcCXmi9TKsX5EUhyhob/WoiCH6s3RO3OCVDmyCbH4OVKNkw4ARMyAOROVGcON1NBpRkLTOOJA2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkH1u7M4XlAAjjyKvWSJ9W1TvJGLqEn5RZEuia3kmH3l6FLBsP
	SbVBhknZX/YqJ6OvOqKuYAtQsqm+4Bm7bBn3gGLmvpNabjzaVDWwkdo/VKyv9aRzPnr5HUBjZh9
	gbxFIl1VYuVztvVS1Ao/JWugO/4w=
X-Gm-Gg: ASbGnctNh03SpIRWDBph0ZkX1ufAZddo26ILvCAXiQ42gLpMfgGTTxJ2vmxE9xAL4/O
	uM9FxLwgb45oJ5TTrLjwoAY2z3PNO4dt6svyB9LG4Vnu+snkAS8tRlA==
X-Google-Smtp-Source: AGHT+IEjdHJzoGpastaCk2hvzRsIENAny++UcRfcc1r+XRDVfBTjJIrUXo239L+yBKsItdxvh3aCKhZhtP0tw3DgmaI=
X-Received: by 2002:ac8:5981:0:b0:467:5016:57fa with SMTP id
 d75a77b69052e-46a4a988dd7mr950725101cf.44.1736184207460; Mon, 06 Jan 2025
 09:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJnrk1aumuyz9J1ZWReB+diDXffRQFr1Et1UMoyyuBRf+s272g@mail.gmail.com>
 <67786ea9.050a0220.7f35c.0000.GAE@google.com>
In-Reply-To: <67786ea9.050a0220.7f35c.0000.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 6 Jan 2025 09:23:16 -0800
Message-ID: <CAJnrk1ZC4orWTbJAKVuDwmRCRRN-WSM6xpcNiGW48P55nD3r+Q@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 3:11=E2=80=AFPM syzbot
<syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>
> > On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
> > <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
> >>
> >> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fus=
e.git
> >>
> >> want either no args or 2 args (repo, branch), got 1
> >>
> >> > 7a4f5418
> >
> > Sorry for the late reply on this Miklos, didn't realize this was
> > related to my "convert direct io to use folios" change.
> >
> > I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
> > fuse_get_user_pages on allocation failure") should have fixed this?
> >
> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.g=
it
>
> want either no args or 2 args (repo, branch), got 1
>
> > for-next

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
for-next

(added a missing ":" after test)
