Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742353AC
	for <netfs@lists.linux.dev>; Sun, 23 Mar 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759593; cv=none; b=kI8IOZVoo5dO932cPRDfFNR14rbppYT7LCbjwOVpjN0kXuwL7Iy6InjGJHBSq/+ALfllo7Z8nnj5mJXOaSkkqrBCYVTN/gGkvWEfs9cKRj4yOFQs3H01Fnjdj3owEWlfHPSenLhdhADN0G463TpTlTHD/tcI7kln82lHUfZhYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759593; c=relaxed/simple;
	bh=/D+nG4uW10nRpZVc2GkyF6TytJKeK32ybhtrWcO80fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+G+QoMTXfgj9pphPGXi8vgybvCK3wRpLN2//RatyhoVzuJZkl7pnT3T0Gdf1giJoUmLVxFZsCjMKriLMkYqk93VjJlIFbv+YJJ8nI68O2pnnLaONwQzwz0oTJCEmNB5GCGpwQX7/cQnPcrZH5d5oPW07duEEFJn4LCFKbaIFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMFmSPhH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMFmSPhH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so5791198a12.3
        for <netfs@lists.linux.dev>; Sun, 23 Mar 2025 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742759590; x=1743364390; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D+nG4uW10nRpZVc2GkyF6TytJKeK32ybhtrWcO80fU=;
        b=fMFmSPhHFW8ehXtipJd9syxJ90igdYEFdNrjxHrludyIc9P8eXEhnUYXo6EyEW8AiE
         KpvdUsyywT95syD2Myw0gLM4lJSLFq0XPDYYsDDZ6/hh0HSjA7M2XWwPBqeQKNkEVxdA
         COOkfp687v4oBKkyDPz9Uwx2fOQYessk/0kye0Jrnty2899+sosUYus3bihWojjIahyb
         Bv1D07yjdOrKqr0g1Pq9s40ccggAmZZg4BImQJHjMJ1LKeP4OzvFnH8WIhE0pMwjD5Zs
         mS2W9awsiMCp50jPEHrctmFBbceSqSUFRQ8bY5ugTSbPc4NumTjn5K61rHTk4R7ItcE0
         RRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742759590; x=1743364390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/D+nG4uW10nRpZVc2GkyF6TytJKeK32ybhtrWcO80fU=;
        b=i0K0owZ0uZj9cwu7TbYQAv1Dth4DH0vfFPznuOf5wT6lcVvzI3AovmGc+KDh3R5RiL
         Ku8gxzUIUDRAdOqpSgPjIrM0zdNK1Vcq9D8IgTNrCgNWTZafypdfMsYl4FVNLYC6P9KN
         4vk9udVwcAZw7/fO3f7x3unOsDkdu9aoigHt2YBDa5Ho5v734W6qYNNaOF6Y/3Niqof9
         R0wLtcNokSeuSa3TnBRBd9rjenUmav/9trFAVaszpgG8zpUQpJ1k/mG+sWhuYVPTjPbl
         viB24Deb8Qhwr3ncGZv/nhiK8gw8cvVH9piYqYA90djMMmOR6OQGV4irHM5HkdoJ1EmJ
         eYKw==
X-Forwarded-Encrypted: i=1; AJvYcCWGUXzFfVNdBmLCTLatJFA+x5OwHKbuAqzz9Lj+UWwaxdx00nv5VYt16Eq3ROXZX8Cc+5t7Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDR1M5HrI/gpE7tcC5DL7y5fH1vcVavILBMcJyuhxHTP19pEnc
	/oCiPTp00QhE7P8HzMailFFDG2me/hkZKlVx2evn+RKPh1of+V/7MpCJLgMKpSJ709wAGWelTv0
	8XGjZ5o2t6fDeglqC/eiS7J6Sloo=
X-Gm-Gg: ASbGncvGWbnjvc0WKquHJ98mv9eHq9zR3FTj0VTkeYGuFpsYS3OjG+J6TN1lxDXRi52
	mmCJMlrprVyTSQF2H7+YV0G7elcPHzjXtMkyiznSYmnQ9JitadHAzpHvLWEDwo7Ce/ia2VjOz5+
	XZcuhN2rt7iEE814RMzAC+/PooFw==
X-Google-Smtp-Source: AGHT+IHoxQWQN8FbIDI0a4E/ODBLoiOjcLkhiQ5MPps/DpREbWQPxM3AVzbSmry+3Kvx9vewOOtvo2jMDaQvoLHZ3vQ=
X-Received: by 2002:a05:6402:270d:b0:5eb:cc1b:773a with SMTP id
 4fb4d7f45d1cf-5ebcd4f709dmr7581807a12.23.1742759590271; Sun, 23 Mar 2025
 12:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250323184848.GB14883@redhat.com> <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
In-Reply-To: <20250323194701.GC14883@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 23 Mar 2025 20:52:58 +0100
X-Gm-Features: AQ5f1JqRBzcP3FWhh1V2ofCMs00Xh5Dt75eWXWr3JMV0jNgQshHIIMywyiTDbrQ
Message-ID: <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>, 
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 8:47=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 03/23, syzbot wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still trigge=
ring an issue:
> > INFO: task hung in netfs_unbuffered_write_iter
>
> OK, as expected.
>
> Dear syzbot, thank you.
>
> So far I think this is another problem revealed by aaec5a95d59615523db03d=
d5
> ("pipe_read: don't wake up the writer if the pipe is still full").
>
> I am going to forget about this report for now and return to it later, wh=
en
> all the pending pipe-related changes in vfs.git are merged.
>

How do you ask syzbot for all stacks?

The reproducer *does* use pipes, but it is unclear to me if they play
any role here -- and notably we don't know if there is someone stuck
in pipe code, resulting in not waking up the reported thread.

--=20
Mateusz Guzik <mjguzik gmail.com>
