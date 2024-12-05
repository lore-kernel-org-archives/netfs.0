Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EC207DF0
	for <netfs@lists.linux.dev>; Thu,  5 Dec 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392748; cv=none; b=t4KbbgDQKw9h0bGrlWIezGtHXiRg9XeD3hIcQTmndu6c15a25dVD2j9+GnZGo23mATKvoPEMTIOrBNMClZu0JidVeogz8ROducdbiCj09tNeQlQ9W30SsqkAudGOFgu0WGVLhxn57+bEChSQT/oivYi+sfI3UPGokd500AYgChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392748; c=relaxed/simple;
	bh=SgIHS645a0AYFH1ctRSGEAJTKS9pLtbEIGoGYT5Xrx0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IDvORc3TMgxMPCpD+V1rVEYBFb7/yt/5l35t+7WL6ofbH9nQIee4g/2Traxl9yeaz6mu1Nx/0AuCuKuFdwUMX//0JBs09/P26B1OjPJ466CRpUbcpcZYirSqxrVCL2OmLpmYBmCn54Azbuqu2DcyIYXkAK1kaqOFsy+rrtn1KT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7d87dfd9bso8724825ab.0
        for <netfs@lists.linux.dev>; Thu, 05 Dec 2024 01:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392743; x=1733997543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lNUCqqMwNBH1sfFW4omgrn6scda2dAGbmRIbTAv4L0=;
        b=AO2L+r8RRZBmlMqq6IvsCZ0rGsjOOeaGEJCt/lB49r2ohrO0kvcQ+K57+4T0ul8SXE
         VGvOWk6PxB1a9cT1mBDfdnHEG3cN9kLl/OEshx0g9nF22Kqxl/XIxrL3yGqOXCwxDeC1
         UM/YSiE57eJe4/qW2ow/yqQrk3Nn0HxsVddzvDcXhnTuphewuwnJZfLzcZRxMifKbs4s
         GPRZUiU2bYzuLp8kVQqegc3+Dmxbzci/buqoOmHFlF3EwkpDb9+H7O10t23kdcDH0vEz
         0LRSm58WuBPHuJQB5r6K43EoY4Bfh+rXj6obZrWz8IuVCha+FLUcFc60i44G9BB155Zr
         jkvw==
X-Forwarded-Encrypted: i=1; AJvYcCVeDaavIbTGxiAlnSHlyAAQiIJHjIQI/NG43RuIq4MlmB7BJsomSaDNrMiUIavNxlpYyd9Bmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKkMBrSrXWXHws0Tphfo7i+1do6tQcOQI2VyzMsJbflQbNG5lv
	Tx+TvwLxt5lOxemNQcVDNsHqyCyTgt8CSw+f4DEPb/W0/ZemqvW25KdE27kWonmDdqGRxV/7CET
	CL/0oLjn+9cxrZk/WLm4rH4Woc3xpicforpddU1YtFqfjWYXbmTY33Ew=
X-Google-Smtp-Source: AGHT+IFavLHBVe3EenRxLgzvIaeEkVCw6c2tXhFegXn7cdD53cnvfTiRuE/EybIckxER921OESEtcxvmumxOeN/nu4vsVhRDpbeN
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c54f:0:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3a7f9a36198mr111101565ab.1.1733392743713; Thu, 05 Dec 2024
 01:59:03 -0800 (PST)
Date: Thu, 05 Dec 2024 01:59:03 -0800
In-Reply-To: <1757419.1733391531@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67517967.050a0220.17bd51.0099.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dhowells@redhat.com, jlayton@kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         c018ec9d block: rnull: Initialize the module in place
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-6.14/block
console output: https://syzkaller.appspot.com/x/log.txt?x=159ca8df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b910f8580000

Note: testing is done by a robot and is best-effort only.
