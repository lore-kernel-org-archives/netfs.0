Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397040B39C
	for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157389; cv=none; b=SX+VU+oN0Pmn3jC5W9GVrB9HSvsFxr7hbZD4mgM7oLU6Ba6I1+zmH5bpqy1RYuZjov9LqrwC5QScszObzOiLTZaY9JeJfigPJ3BaqkmnmEwqVyYliscPzZqHidjXcinwMO1Zq/XIPP4A7gSsrfupFW5crQQTCFjZAXl1xCl5DjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157389; c=relaxed/simple;
	bh=zS6b2JoVb7nseqJ2ddI79TDTJUXKZDgYnRPOQXP0Eug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LBTfBw7CCM5vkX/+K4u5efChiqrqjSUhpVWqXwQ6yu+kJj4rcNNUIKqiXs0lDODLjwJ6C4HqzCMAaycJ4iw4/1TZtLocCFyirf+9Hz+sYIY21MRRNAFJXn690Wsiu2sXu7bHqEfCfO2oXWipyvFWkB0ioQZq+L1AoPXJjugLeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6aad64f8965so1746798eaf.1
        for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 06:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157383; x=1785762183;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NDzA112ysxFy6ewvLv746I8Ostj+7rzN7xO0v+/DVpU=;
        b=OvKK1iODO2gl8gNDKramKQUMYe2UropkqcnTl6Fa/MsUFTUzSn/RTmu30yst+NZ6dx
         kK3QZ+yao9MEYFBue7UDp2FuYm7+i3ufWwEK4TNwmxoCUWJVyurE4GzlO37wVP2wA7ZF
         wFBuofW6BNf8D0BKJUahaak9copqsp5LAcCysBGzm02MBkgWATXF0YDDWKcsagWyS7x4
         +WYB8V/QNzPJ8xGkLm0xeTMPEjbzsCR4vidqvsyzQF6V2wXrKLe0l7GiA9WacfksbFv8
         rbODQeKS6KQAMGh8FSY2a3Q/+R6gvsYI6m4WdWPiVkmAWEiegCupXqodVdNrgKs+j+JY
         Z5/g==
X-Forwarded-Encrypted: i=1; AHgh+RpzJuYkJRwLXte7EVGXvdfTLXqkdCTFgCiBXakcwnvOslfqIUkupK7+waEZ/muLb6nM/LRQCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzyu+GUbQPONiTKDX5q7iDHW715gk9XltD8y/+tvYb4W8YBGahi
	VQ21/dM0P6ckcLC6GuZ8Y2mnjROI5RYkXAtXpraOMqywMLmP7j1jGJSPB0UYmjh5rLUQq/AuijY
	QV/6ns+vavm5bnFLbdPDR6qquXNohuq45JDiXEAiZxoJ+QuxT65KqZ98g2KA=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:829:b0:6aa:ef00:d568 with SMTP id
 006d021491bc7-6aaffca4991mr5776702eaf.33.1785157383139; Mon, 27 Jul 2026
 06:03:03 -0700 (PDT)
Date: Mon, 27 Jul 2026 06:03:03 -0700
In-Reply-To: <1098525.1785155757@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a675707.073198cf.94f0f.0031.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
From: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
Tested-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com

Tested on:

commit:         6836db8d netfs: Fix folio_queue ENOMEM in writeback by..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=170d58c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d69870d5e052935f
dashboard link: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
