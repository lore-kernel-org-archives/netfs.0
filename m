Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233315381A
	for <netfs@lists.linux.dev>; Thu,  2 Jan 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849099; cv=none; b=iIDv6Dpaw0rVebEE2C+KlU+Tra/zxZDZmtYBQIvK/5GWbIEMcDgrXbitRd1ZxmuXc8NkZh7rNoprHtzIA8YvIH/mI8VaONA4GBxWP+WnA0oMknCeoa2/A4vQTEoJ6zij89ltZ78UiafyrMMj4A5AX7rzrTleMc6RvAJ8LheUo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849099; c=relaxed/simple;
	bh=P5rKo/20HCpsDorB04vTXU/JHstbfmXg+E+FwLLvuY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv2NNsfWAQQ8k1YbjPJ3D6+wIxkr15CTl8Ee2Kq3P0wHCkb9BtUc0me4YuF4LmlqbDkj2rcDneln4lPO1S1U9k2VmF8VnCWRa6O/TRphPlIBpUn4sLOFTytS1sezJKx7XBeiqhOWOfGQJB1MPtciPavkMcBrNMF6gdM413m5lD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LpndUqo6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LpndUqo6"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678afeb133so106752931cf.0
        for <netfs@lists.linux.dev>; Thu, 02 Jan 2025 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1735849095; x=1736453895; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=whjW7ansRJg9of7azCwOlJGbs8sBbLB1p917lKhKZC4=;
        b=LpndUqo6LXeJdB9JcuWYqKyH5K3c2HetZQAm4WfTKZiJhaTN6LxrZ1sqjSpFIm6+86
         lv38bCe1PFEf8jOB7kTp6ETf0wiI0SyCZC44d9DNAfVHxAN53HF7BdLVwG4XXbBWlfyT
         2MHwW6l4CSDsDc9zsukb1g1JbKIKSrrYjGRFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849095; x=1736453895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whjW7ansRJg9of7azCwOlJGbs8sBbLB1p917lKhKZC4=;
        b=kA96UgFV3y+1B6VGJmPDzcvUQPUDL6DUQDLzbAR6DHWhB21JDtDkUoSn5TDU/y60fu
         3O0ooKnJHAalbs9SLlJU5zrnBt8K07t+dURuX0455Bu2Hn9vuTqyC65AVGBAXN+GPcmt
         07otnMtXWDlVwFUeK7ujW9mlefzJ4O+5B4lL3q5DxqsrM/suGBwcyAe7d68kM17U/Zzw
         6TkWlEuULZAqxq3T6XNQRd1g5Q8zL7SemddevnW6/nJSMIoKBgHOaF59gy0nyoDYGyao
         Ut7itvGcfbJuHc2VxeA8jTQ5qlP99YRwxJMcMVRoD02xHHJc4w00hBBtwDMFMygKEiJR
         +efA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Su16Bnk9fKJ0lmFrvWredORbiTllJlBXLLDBgzcC7jnnnx//l5iv3JROu5mQuF+Px5Uhsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfeQKkmOtLB0k7rcNnUHClJOhoFonUPGGcISxgpfq4z+zNvqzp
	DdK04Pcrqm6G7Z3EbuGiV66k1Ud7nuAjEg7Ch9EzNQsC3STm5ZSLJ/caEhjPmCKlrEwEU2l7TR6
	GG4+zLb3EMyOWkXuBONvAayjKqBPo0pCD/gPRQA==
X-Gm-Gg: ASbGncuqsaS8Pktn9yZewfzwzz8f4S+JAK8rTtIp056LX09aTWLPXyFReNdWKaDdAfL
	ZDjSmW7mqaKz4PUGV0LVA2CUfYsexSvOKwcExdA==
X-Google-Smtp-Source: AGHT+IHnssMS0rJW35LIoTzFQOzDJTFx8qrOIdHzeXqJduLtr2ZHV+Q05oV07SAY6+3VSl7j9BBmUdUt82kXGzSb32M=
X-Received: by 2002:ac8:5815:0:b0:467:51d7:e13 with SMTP id
 d75a77b69052e-46a3af9ff9dmr746325331cf.9.1735849095639; Thu, 02 Jan 2025
 12:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <66ed861b.050a0220.2abe4d.0016.GAE@google.com> <674a5a6e.050a0220.253251.00d3.GAE@google.com>
In-Reply-To: <674a5a6e.050a0220.253251.00d3.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 2 Jan 2025 21:18:04 +0100
Message-ID: <CAJfpeguK9Baf4hxBhqS_313bo9Z0ZAGMAAbkaOMQRKTK_auk=w@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 01:21, syzbot
<syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
> Author: Joanne Koong <joannelkoong@gmail.com>
> Date:   Thu Oct 24 17:18:08 2024 +0000
>
>     fuse: convert direct io to use folios
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1033bf5f980000
> start commit:   b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1233bf5f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1433bf5f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
> dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14534f78580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c3d3c0580000
>
> Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
7a4f541873734f41f9645ec147cfae72ef3ffd00
