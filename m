Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484B38DE9
	for <netfs@lists.linux.dev>; Mon, 24 Mar 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822249; cv=none; b=Q2J0loP+PwVjn6IFxDdD2LsdxopS8Y7qibWbMKaU40LwelSNw/rHfL3+jjg5N81Nuxgaagvd2qgRl0a9zOmmPQXpgIccAubvAfm7FT4DBiMljD/6oCfvpvimpp0AJOYdYNFKZe/Ony8pFlcH5qZ6VOTgySHtjh62gPw5Ogq6rVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822249; c=relaxed/simple;
	bh=7qXoMmWqfPi18WcHquENtu9KDJdfz1Xkcy1CKJFR7+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqFOI0f0ZI8POIGjZYAy/i2yim69g/RVaQpscu2wbITzABZZCmhQ6+1Q+6lyDBOH98QdDvDKTaAEd3hp+0dJHgoBJWyf5vwYVvzkuojIZrJPEfukY0mRGkKHKu62/J5J/aPJjnZpT6JdkF7Yh1uXzngLiFGz5zutbmDFZ4mxnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgOi2h2q; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgOi2h2q"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so6673252a12.2
        for <netfs@lists.linux.dev>; Mon, 24 Mar 2025 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742822245; x=1743427045; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJcJ788uUOtOt0MV4TH6R6BH7Mq5ZTaLme2mTxYcmww=;
        b=QgOi2h2qLox+l5YomHZp4cEDDq8Ib6jp4eSdL6stSc6rrT3aYcRh03At/A1Wh8FP2B
         JbNwmV5KX8cY6fE1w4BpDLVzKlhMpbNzJZlurfGPT1451YHwJy35G24Pacnn9Jo0edz4
         1KNQ2pnAOkWhux3M8rWD1p3OcQ3kboG0s/vdyi5jkk31wnX4JGBKNOOP7tBzf9Gqh7XV
         FhFEyWbuNPLrqLavW7nqJC/+mq6AYXAzQsnbFqpStf+bHGu3TVV9OVLfQWVvWnD+5i2J
         OE2cokUIZf+lOZkaV4ku3gZBxdTUl1w8EhwMGPNqo/3vJP1qrJacbL0Dhs5VTVpMXJIs
         scgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822245; x=1743427045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJcJ788uUOtOt0MV4TH6R6BH7Mq5ZTaLme2mTxYcmww=;
        b=E56pXeWyYclHEwNBC7GxAxRCEuytzkMgiK4nVHm+elAzqi8hsaS4uYqfK39v0qPCnz
         msrf2EPI0bdP+XzhAqJGoaoJQWXs1vo4zn8Dyq8xt0zs0kyMEWPvsyUH46hhyfSxGMZW
         N6OB6U+l6UhqXtIYqepZrVg5vBjyPHtuocSP/Uzg/9WOHAGdfHP//fJYtLfEK2/WY5Kq
         Yr9sOrT2Q4AigPCwsCyaHTLlUKZ9ZFST9DF73N+rxRgwSnWizmde8zA+yNqIOCKiwLJQ
         a1iGltahMZwa+MMpcaNQsbOmFPeKLMXTNaiOjeiHqmCad+iB/vI4xbRuvkI7eUefFT76
         rEyw==
X-Forwarded-Encrypted: i=1; AJvYcCWPVNZjs9O/qlWyZhwEdWhhyU2Sq77gD88PUt8yOxJWVgdkCc3HD+6dsuX2+VzQLhhqKm0GAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPJrSAFy+636Bm07wgj49N4TqS6mMICIkRk0QbmDUa+XpgQ1uK
	Gmmv/3dZaRO8xqZI4aUm5C64OPCEAvXzejLvHs/StBcDyNh99j3/nUychK6sXN4J2Fx0jCs819D
	V7n7BvBwTNIoLahmY5dYCvvqbzZg=
X-Gm-Gg: ASbGncvOQZa8j8QFjanHlkCpsc+I9i+hEueWtGMvi5gkbhtL1XrNgoaDhbnkb8kyJxF
	sGwDG8sIIx2aBuyYwC1p1YO+dQwoQrI/g3UpVJPrxp3vX8woeluNPpPTubsO0m1CYu/bJDFS6rt
	GlvPjvSW8zWqjMS2guiSCg/sXnHCT7J0+kmy0+
X-Google-Smtp-Source: AGHT+IGLXdKjZuajBWmDkKcpbXIVLx81EZwkpu+ArMbI70FzxgSKBU0Zd/r8N9kuY8uqTFEbh6WNd4jRDmF0R0ryN6I=
X-Received: by 2002:a05:6402:2694:b0:5eb:ca98:3d3d with SMTP id
 4fb4d7f45d1cf-5ebcd4ef489mr10328328a12.22.1742822244551; Mon, 24 Mar 2025
 06:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250323184848.GB14883@redhat.com> <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com> <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com> <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
In-Reply-To: <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Mar 2025 14:17:11 +0100
X-Gm-Features: AQ5f1JrrNeTDkLJ-5S8FhxMASlkBIAYR1m8OKybvtOlyBqMboGj2sbmx82u5LrE
Message-ID: <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>, brauner@kernel.org, 
	dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 11:48=E2=80=AFAM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Hello Oleg, Mateusz,
>
> On 3/24/2025 2:32 AM, Oleg Nesterov wrote:
> > Prateek, Mateusz, thanks for your participation!
> >
> > On 03/23, Mateusz Guzik wrote:
> >>
> >> On Sun, Mar 23, 2025 at 8:47=E2=80=AFPM Oleg Nesterov <oleg@redhat.com=
> wrote:
> >>>
> >>> OK, as expected.
> >>>
> >>> Dear syzbot, thank you.
> >>>
> >>> So far I think this is another problem revealed by aaec5a95d59615523d=
b03dd5
> >>> ("pipe_read: don't wake up the writer if the pipe is still full").
> >>>
> >>> I am going to forget about this report for now and return to it later=
, when
> >>> all the pending pipe-related changes in vfs.git are merged.
> >>>
> >>
> >> How do you ask syzbot for all stacks?
> >
> > Heh, I don't know.
> >
> >> The reproducer *does* use pipes, but it is unclear to me if they play
> >> any role here
> >
> > please see the reproducer,
> >
> >       https://syzkaller.appspot.com/x/repro.c?x=3D10d6a44c580000
> >
> >    res =3D syscall(__NR_pipe2, /*pipefd=3D*/0x400000001900ul, /*flags=
=3D*/0ul);
> >    if (res !=3D -1) {
> >      r[2] =3D *(uint32_t*)0x400000001900;
> >      r[3] =3D *(uint32_t*)0x400000001904;
> >    }
> >
> > then
> >
> >    res =3D syscall(__NR_dup, /*oldfd=3D*/r[3]);
> >    if (res !=3D -1)
> >      r[4] =3D res;
> >
> > so r[2] and r[4] are the read/write fd's.
> >
> > then later
> >
> >     memcpy((void*)0x400000000280, "trans=3Dfd,", 9);
> >     ...
> >     memcpy((void*)0x400000000289, "rfdno", 5);
> >     ...
> >     sprintf((char*)0x40000000028f, "0x%016llx", (long long)r[2]);
> >     ...
> >     memcpy((void*)0x4000000002a2, "wfdno", 5);
> >     ...
> >     sprintf((char*)0x4000000002a8, "0x%016llx", (long long)r[4]);
> >     ...
> >     syscall(__NR_mount, /*src=3D*/0ul, /*dst=3D*/0x400000000000ul,
> >             /*type=3D*/0x400000000040ul, /*flags=3D*/0ul, /*opts=3D*/0x=
400000000280ul);
> >
> > so this pipe is actually used as "trans=3Dfd".
> >
> >> -- and notably we don't know if there is someone stuck
> >> in pipe code, resulting in not waking up the reported thread.
> >
> > Yes, I am not familiar with 9p or netfs, so I don't know either.
>
> Didn't have any luck reproducing this yet but I'm looking at
> https://syzkaller.appspot.com/x/log.txt?x=3D1397319b980000
> which is the trimmed log from original report and I see ...
>
> [pid  5842] creat("./file0", 000)       =3D 7
> [  137.753309][   T30] audit: type=3D1400 audit(1742312362.045:90): avc: =
 denied  { mount } for  pid=3D5842 comm=3D"syz-executor309" name=3D"/" dev=
=3D"9p" ino=3D2 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:objec=
t_r:unlabeled_t tclass=3Dfilesystem permissive=3D1
> [  137.775741][   T30] audit: type=3D1400 audit(1742312362.065:91): avc: =
 denied  { setattr } for  pid=3D5842 comm=3D"syz-executor309" name=3D"/" de=
v=3D"9p" ino=3D2 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:obje=
ct_r:unlabeled_t tclass=3Dfile permissive=3D1
> [  137.798215][   T30] audit: type=3D1400 audit(1742312362.075:92): avc: =
 denied  { write } for  pid=3D5842 comm=3D"syz-executor309" dev=3D"9p" ino=
=3D2 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:object_r:unlabel=
ed_t tclass=3Dfile permissive=3D1
> [  137.819189][   T30] audit: type=3D1400 audit(1742312362.075:93): avc: =
 denied  { open } for  pid=3D5842 comm=3D"syz-executor309" path=3D"/file0" =
dev=3D"9p" ino=3D2 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:ob=
ject_r:unlabeled_t tclass=3Dfile permissive=3D1
> [pid  5842] write(7, "\x08\x00\x00\x00\x1a\x17\x92\x4a\xb2\x18\xea\xcb\x1=
5\xa3\xfc\xcf\x92\x9e\x2d\xd2\x49\x79\x03\xc1\xf8\x53\xd9\x5b\x99\x5c\x65\x=
e9\x94\x49\xff\x95\x3f\xa1\x1c\x77\x23\xb2\x14\x9e\xcd\xaa\x7f\x83\x3f\x60\=
xe1\x3b\x19\xa6\x6e\x96\x3f\x7e\x8d\xa4\x29\x7e\xbb\xfd\xda\x5b\x36\xfb\x4d=
\x01\xbd\x02\xe6\xc6\x52\xdc\x4d\x99\xe2\xcb\x82\xc2\xa1\xd4\xa4\x5e\x4c\x8=
9\xba\x99\x94\xe8\x2f\x85\x4b\xbc\x34\xa4\x0b\x3a"..., 32748 <unfinished ..=
.>
>
> So we have a "write" denied for pid 5842 and then it tries a write that
> seems to hangs. In all the traces for hang, I see a denied for a task
> followed by a hang for the task in the same tgid.
>
> But since this is a "permissive" policy, it should not cause a hang,
> only report that the program is in violation. Also I have no clue how a
> spurious wakeup of a writer could then lead to progress.
>
> Since in all cases the thread info flags "flags:0x00004006" has the
> TIF_NOTIFY_SIGNAL bit set, I'm wondering if it has something to do with
> the fact that pipe_read() directly return -ERESTARTSYS in case of a
> pending signal without any wakeups?
>

Per syzbot this attempt did not work out either.

I think the blind stabs taken by everyone here are enough.

The report does not provide the crucial bit: what are the other
threads doing. Presumably someone else is stuck somewhere, possibly
not even in pipe code and that stuck thread was supposed to wake up
the one which trips over hung task detector. Figuring out what that
thread is imo the next step.

I failed to find a relevant command in
https://github.com/google/syzkaller/blob/master/docs/syzbot.md

So if you guys know someone on syzkaller side, maybe you can ask them
to tweak the report *or* maybe syzbot can test a "fix" which makes
hung task detector also report all backtraces? I don't know if that
can work, the output may be long enough that it will get trimmed by
something.

I don't have to time work on this for now, just throwing ideas.
--=20
Mateusz Guzik <mjguzik gmail.com>
