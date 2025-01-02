Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7B17DE2D
	for <netfs@lists.linux.dev>; Thu,  2 Jan 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849099; cv=none; b=TkIO26MZjXyhLrK4gHlVMCZcgAgBWmmexUNheuTphVGfiSdnq0lGB7Mh546YiZAb9WuDOZBcwHNALv1OhthggdRXAKClFSaDiw1NIRz0Su9X479b+jS5SWUUlfJTl4N1mIzH2aqX9MH153+n1bL8lg0dxpXSSC9wdKG6Cp8zsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849099; c=relaxed/simple;
	bh=u0ftigakl3TTVR2gSv10Aaoafz338ii3ic3mzHJiFUo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=J5uzclJrDWJsMUhqsyxVs/WvdlasM1iVsQ8NsIs0yzr9oLvFQLPrEp0WMEoHrOQ19h/6cfZ6CAvsGFKwrhZqJcw+QpPQGEtCj/nlcMc9syu1T6kQv4YCIDawl9FQjPjdNNhKDRPwpRCyBuTcTSmoRh8j/ZXGivab4/xkNm/Umk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so202364325ab.2
        for <netfs@lists.linux.dev>; Thu, 02 Jan 2025 12:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849097; x=1736453897;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyt1KqLVc0pramu9rGXFNwVyDBSM+pe2+vkEywK1yrE=;
        b=qpgFWFw7d4S+pZiVSVGCCP0jxd6KjudwirWMQ/XQBTVCJS01aYKivxaF+pXo/Brr98
         UFKbVtBQe7fTNwIUXmUhxcBMvLQhMTWoL/IfkUaR9xtIxfWZI12U3RD/gKpOIcYcm0oc
         7MuY/0G0PopL43Jb8yGXeq7qoA8ST1X9cK+oBy3w0bZFERx+PO5KpaP4izSkVr/XPlWY
         eKpf4v+7Vah1QhBuLoMJx9EIeCe00XvUz/QGbuV/tgR6caW73H16OriBfuvlm3ezAcMb
         NOJLmFm4qzerXj/35UuFgr2fpRzVXKX5cCwD8BEvGKiJtfoyS9MVyE2zqooaJhtlIWMe
         2l9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiI2Nmlc/CMK4XViYrYJdME2ZuqkXbtLEMLsdgVem4eQTdict5E9ZdpeE43H4YJ0eWFa+X4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7AiSe63vzoAjApWDn9IyvXZlYnasN4bpRf/zuBwHfLH+IyeLT
	gyiLHcHRpswCHrI8YEcVLkOog0puDlQsxgkLP67F78Airv4BfQk4HK8Le4+klYPA1tsYO/Y6VJf
	7n3CVX+fLiYdB9dW2rTyTgMFZ5JOpVua+sAos+jvnVkx1AV45d2SK4xk=
X-Google-Smtp-Source: AGHT+IEow5vVrCoxJ0lCGkXlgJXpV+283139zHLDUjFC2pU4oYrUWU9RnAjC1G0X2pUKH78cVkuwEuG0RlLVFSgN4co8u8E0DJ47
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2684:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3c2d1f7576amr381704985ab.7.1735849097221; Thu, 02 Jan 2025
 12:18:17 -0800 (PST)
Date: Thu, 02 Jan 2025 12:18:17 -0800
In-Reply-To: <CAJfpeguK9Baf4hxBhqS_313bo9Z0ZAGMAAbkaOMQRKTK_auk=w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6776f489.050a0220.3a8527.004f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: miklos@szeredi.hu
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Sat, 30 Nov 2024 at 01:21, syzbot
> <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has bisected this issue to:
>>
>> commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
>> Author: Joanne Koong <joannelkoong@gmail.com>
>> Date:   Thu Oct 24 17:18:08 2024 +0000
>>
>>     fuse: convert direct io to use folios
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1033bf5f980000
>> start commit:   b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
>> git tree:       upstream
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1233bf5f980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1433bf5f980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14534f78580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c3d3c0580000
>>
>> Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
>> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> 7a4f541873734f41f9645ec147cfae72ef3ffd00
