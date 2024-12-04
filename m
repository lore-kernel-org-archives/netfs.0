Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361FB1F756F
	for <netfs@lists.linux.dev>; Wed,  4 Dec 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322006; cv=none; b=snkXpruNO9Sgb05ob4nRmfidYPIgwm2m5SRlgDbgJHLxFa6/zXcxHUs4cwD7qdkd6Da9M8Z2rENAYbrRRfZ/Fqjy2BpiVtHShEG4EyVdrmYjIjSwbISoWTpM9jNes5dK3sgg+dRJkbDO94saFN/QRu3iJPJyhwo0c7ey7oTdW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322006; c=relaxed/simple;
	bh=tO+SORHpKmrWTcl93DOLCo0umt8XdOBYvIMpAvA3wgg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PO9on6WjGECBsKEEgmXZKMDNPVRFkVGCheM4brfLjs3DJd3j3qQooCF8RqBV5RP5+WbHBpsAKHX38RHnVRlVEJw2Ui0MJ/W8YlKX6Fd/SYBUEiEqeMe8mGOE2a0VcaTH/xdUivc8UEQWotyyJUdRHQhrcnWOxMovGpOc0Z7vQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a775636946so39793645ab.2
        for <netfs@lists.linux.dev>; Wed, 04 Dec 2024 06:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322002; x=1733926802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KVEhwAjHAH6DwhUQICA5+2FgGfgLP5QSHauX9xaRkI=;
        b=gz9qzn0SsYKknLkJfHsCmVDdSx4jBDRL5Tp07pXn1i40WRWTocLuUVVYMO2Q0uVcC8
         D9tDU6ihETLxoKwZj+gkRu52RD7jbL2h/bhGj7i6miT0OKgkjP7tWagPYRCxKpEsu99g
         h/HLnVFk8z9DVYMr3BjPeQ0CeFOkITIbcLn0wlhCttZKJiIlaUIOvqbJ8Q00x4t1WHr5
         F4M2UVUZHpoZ9oXPT/c6cCqL85zvN83I8FITxnbIkI64MUBx9tWKvnBuHuBP598cE4TV
         OLk33EGZK3PSyPbWcmg8lNoPsOrJQKwuKdK1ziUcoNFEdMrPYCbYlDI+aBA2bDhX4WX+
         rW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDuZ7WcfE2df3sy/k0xIqM199Mzo9DLywRAshSZwaGe0tvQZ0nrTo6JwK8w6dG0XQfTHDFtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdPGvht+IdpqJHNUV+N/L87toPTlGe2fD8w81UFONRxdi7Elre
	1arOeG9RyW1gKH4MTltLezxX0srNCSjuqeYEgTXSxnEPDrIAIhPZYAWikKsA7QMZ/6vIrdhlVcx
	gkcGUH9tlBYrcYk8qL1B1poZ8Kb9tchMdJzMW8ObJdY/W+UcqsqZGeHs=
X-Google-Smtp-Source: AGHT+IFCfKe19gEn2IpmATv9IPOuQmAwJeYIZY35tvobgYCj4YIwz7jBav1nR/Rzgpfp/T5bdc8Tcp8RRuHIAae0Yhb0GSO7H9tV
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3a7f9a4e005mr86299875ab.13.1733322002409; Wed, 04 Dec 2024
 06:20:02 -0800 (PST)
Date: Wed, 04 Dec 2024 06:20:02 -0800
In-Reply-To: <1128092.1733320787@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506512.050a0220.17bd51.006d.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         40384c84 Linux 6.13-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.13-rc1
console output: https://syzkaller.appspot.com/x/log.txt?x=11f960f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1249a330580000

Note: testing is done by a robot and is best-effort only.
