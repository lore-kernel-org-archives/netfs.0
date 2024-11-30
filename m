Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E1849C
	for <netfs@lists.linux.dev>; Sat, 30 Nov 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926064; cv=none; b=pUdKtX5AvCrLhsXd6PR3h93yCu/2umG25V1ToJyJ6K7Q+kpOTyVyrg35vpdmC3wqdq6qobHKr7OJ2WhJ4U/1n0q3RStm0j+spHCYdUofmepVUyjSkjK1FuDkW8C5rn4SzKC7eUhCsVZ1RT6sJwB4zBxxWVYWaDyATRFltJRslb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926064; c=relaxed/simple;
	bh=0EV1a/PEqgBijVEwNPL6KCylvy2Zu2KPS5sJdNJ8kBQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2FVUByXlAZ2tvLN47+KDBNjCSvfqxkhLnvvweg2GkAJ/hzP0u7TO2knwaF/LSw1xOoReNWp9dk8WR5WWDStY857t1n+iwO7L/BLiyCpLFkS+gW3riMyQ61qqHucv1Y6EGE+Bg1UhJqYYzlxnjRC/Fj48bvbrjzJQ3mB+/y8VTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so20959555ab.3
        for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 16:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926062; x=1733530862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVfJflQw+zqDYWm6LdH2mWrvKmzl57FI/2or0aBkVqE=;
        b=mGrKjZVHS3pw6Vaf9e6PO+xkuTd0tyifXTx6eJ74urlZbaQjJp8TF4cfdF/ZF65Le7
         EiM3Ianmv1PoSjOUSkQudlM/LzxZMkuOWNe0El3Jc48ViddhYjQYwwk799qrtuZaa9ha
         yidPJAnXkSnypjyjZJCrJ5oUeUsXVvUS5u/bdBmEHEtHUf42YQENSpEfrwF2g5Ggde0p
         Kd7t1E/WF/xtZgQ2f1RvnNRhlv7Et7Xztt35sTj5Ac/X9Kk1wTB/qAuH5lCc1LkPuBn6
         MuJwHFRbip88YU9JWuiiHuxRwiXxYJd7ZKYSSmW3b1XgYYdSgnb2oQqEKYKkzRMueZ+M
         hRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyoZAyf15uV5/LCKk1HmNoMrRQBkj5w8fWX9SqXE1pqKsGiizT4z5b9wetygWYQxzGO8EFgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKDjQf7GggOgDFQHyuyPTYNpd6r7Eg9DyomlASZWbcSE3nUEK0
	nVVJE2228sycuFd9PZVAIZMN9HM9UmwYr8xrZMNMIwcrDRdkHSXrsE9IARW8Vrg5gXCKvkOs+ei
	rpPUgEI9kEexmp2hI03cYGvxEcvP6I9mFFqncD1MDUcFWR0ex+P7tZSs=
X-Google-Smtp-Source: AGHT+IFVKCt77VV9eIgoBFjrQ5FGd4u7RB7QruWUYFiSaKsKMQCsCEdI8hJAH/havveNDzJ2pYVF2QA5tIzx5GFl6ti8PZAgyMCD
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a7:2b14:add8 with SMTP id
 e9e14a558f8ab-3a7c55da135mr159559955ab.18.1732926062688; Fri, 29 Nov 2024
 16:21:02 -0800 (PST)
Date: Fri, 29 Nov 2024 16:21:02 -0800
In-Reply-To: <66ed861b.050a0220.2abe4d.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a5a6e.050a0220.253251.00d3.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Thu Oct 24 17:18:08 2024 +0000

    fuse: convert direct io to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1033bf5f980000
start commit:   b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1233bf5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1433bf5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14534f78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c3d3c0580000

Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
