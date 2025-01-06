Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DF1DED4A
	for <netfs@lists.linux.dev>; Mon,  6 Jan 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185327; cv=none; b=WwE9MLs7Yyrpyzdts2gLIBFz7s0FH7poNTEWja3TScoie5EoWeyR/xaUuN0ovWCIGLIxnqj8loW8zEh8dubWmSTrPDJyYgA4ZudkgurYLAKKYWyfNE3OySlZiPVPH+v42N6jLBEGKylsF30f5tuiPgGvdUpbOfXRnh0T0t1CnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185327; c=relaxed/simple;
	bh=qDoZS3NKdSeE+nCo/Q27/As6lKC0AXdtcZdMKhSej3Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lbhcmS0vhWqx/5zfx2g6Ss3Digo458mYlDEAYAl70vrAMzOyxciYB9EP+8H6D+9s8JXdWgYC9+qia8CNj03nGDHuNLhpaYBKnnx81g+GQptC83YC1y9MA+zyXrvq6ccjQQIkOfDnOdZI4wyS2hDnFIPHOz02lLdexdYuTnXsokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a817be161bso142712495ab.1
        for <netfs@lists.linux.dev>; Mon, 06 Jan 2025 09:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185325; x=1736790125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNENMpa70ZFUxpC/qH5uyHnJyYbgF2N+67wGvKH0tJY=;
        b=WmT876W6LREg4njG16mmqAvL3/Q2TsdWukiLpTCodieXzLi5/LzGiuzhMwEr+06Udt
         yHVw+8P4BrV4A/mmev/kd2nIzH4tmmtpWNmZuxZAd8kxS5k+zIilMRZglZT61NEuYZnU
         Jfe7+t9GTJ+PafWGvdSRon6OU0xSS7GXUBgFni366vvi4BHG/8v1o1sH1v1ecPJxKTc7
         8Udx9BOC+IvSRtfsXMfvnHigJE3rbYUvuvywavdrAfnVgGLRF9OxdktD/YhzT1jgzhok
         +yyBr/KEzMK5QodaNv58nUUxTz4mdh3BSN262xjcK/FIjaRXupQbhfFx+saWAYsFnf5L
         cn6A==
X-Forwarded-Encrypted: i=1; AJvYcCXQeWuzdDYsbEilpuMLLkbVrfY5yJ6+ouSY6FCu0vU6vvUbuXPCzjsX99w/cY24RLBNtvdaHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGuqYAN8M57tFECZbs7FMnqd7hpPwD3BD6Azy7lNKaQoCKvAu/
	JllOCLExvX+OeMtHMeQDNfgXHH66Zvnyw/gsqMiaTAPvJ97T4rRi4+2C1kFn6GM8LNeSvxq5X0G
	5lmgaBelyaHSpJz3tKZwSk+CcfgxtT2J8WwOzY2wWl5XMzWE/qUOQxyQ=
X-Google-Smtp-Source: AGHT+IH2sA1PHDte7MnFAI5UDFyl6+57MyFTp+jr53IHp24CXdnaVcc7eiEp40FSRBdicfxfzHzbowsbHGx/11z9/QdsFQIlNKjo
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:3a7:e956:13fc with SMTP id
 e9e14a558f8ab-3ce31d3c1c3mr1609715ab.5.1736185325499; Mon, 06 Jan 2025
 09:42:05 -0800 (PST)
Date: Mon, 06 Jan 2025 09:42:05 -0800
In-Reply-To: <CAJnrk1ZC4orWTbJAKVuDwmRCRRN-WSM6xpcNiGW48P55nD3r+Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677c15ed.050a0220.3b3668.0016.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
Tested-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com

Tested on:

commit:         78f2560f fuse: Set *nbytesp=0 in fuse_get_user_pages o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16eeb418580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0669984e46cc674
dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
