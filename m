Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26D3019B9
	for <netfs@lists.linux.dev>; Tue, 23 Sep 2025 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657545; cv=none; b=HsGjf5rzlSbCOogowZRRcXDWShqqXiwlOlv7hx5pxqUcpDfqXUg8juQVMIBf4zIOSC6FOr9tg+y8SPZIPI4Ix1cNRPI5148iCqktq69RxDu5auxATuHvmFt9VErP8Y5fve+TyNvF2Whb+BDGkhIkeMaJEXdKI5KfgFygMC9Lww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657545; c=relaxed/simple;
	bh=WbRxxvPu2PII9+tVZPTYHIku5xjnJJfqpOzcsOGOcTg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pn1lX/XpQjdE4u+m4wG/oJpcDp91E5ntvoW5PjW4/5vpHBlm4bwmQUWPJHFY1o8wFIs27KfpO217mnBdn3poe4yBgYFt73pA4ux7RPCe4FB4TryxhhpalaO5tN1TgmGZPbZ4Hk/rccWy9i02oT3rXsPo6OpZ/RYNI8ynsfR6F40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42486f6da6fso62901685ab.2
        for <netfs@lists.linux.dev>; Tue, 23 Sep 2025 12:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657542; x=1759262342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcaaZPCV5Qrgwa3vKDEUNa/ct40/p9wKCLJtyWA+kyQ=;
        b=c7rNkyWnjWMiEehXUjW3MpSS96yQ1QxhZx9A4JFUAu7vnKNi/rWZaq7mAwD8mpVr+4
         MOWlfPmiCmcQvCilqM/zdfRSm5JyHmvHe2hiWKJXZZxDDCc0BBhPtM0GtVDqaLEtQo/E
         XXP8p4iOaZ4YdVhqvPc9Jff/e5C49bbzYoURY0v3DF84xOYMQ5tQWSikiBNZch4Lmcz8
         i/mMqv0SwR8SRyvlaERU58xo5qW8eZJDIJPkZwaIs3AdnP5y3czvqiRDr945i8O821aJ
         /gPEa8qkz31qelNkKVjKnU8dYRr8zpv6E9uKlwGl698lqsEeplVqMhLDbRO+imIvV5Ls
         rAPA==
X-Forwarded-Encrypted: i=1; AJvYcCVSRcZeUni7sUYythSzJAeaKlUjEvDdnLjdDRR+EQnRez8c3MiCJTK0KfCkVgwT8ZqUePJvww==@lists.linux.dev
X-Gm-Message-State: AOJu0YycLH6CKAMF17jCvC89htctQ4WLWoSXPjKEaoVrbAu7jqha9b6Z
	h+PavCAy/sccLLQ3F34nZGZEgWEAaCdPAvUsN45E7ziRpj/VI17ZT0oZF+WtFPCcmKXgjjF/w0s
	eByiFeqp/tRq9x0dXLevu3XMMSfa1p49lsbZGOpOYX8KZKx6amGiM5USgAE0=
X-Google-Smtp-Source: AGHT+IH4ryecd7+jD4K6kYGAIwNEyzeiCtIWaDcMQ3DqckIrtsaX5FHyU9Wx/aV8dwEqItA12eZFVdFCQBiegXhWf5yf0gEyZVTH
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160f:b0:423:fcd6:5487 with SMTP id
 e9e14a558f8ab-42581e28b8emr65860075ab.14.1758657542574; Tue, 23 Sep 2025
 12:59:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:59:02 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2fc06.a70a0220.4f78.000d.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, danielyangkang@gmail.com, 
	dhowells@redhat.com, eadavis@qq.com, ericvh@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lizhi.xu@windriver.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a3de58b12ce074ec05b8741fa28d62ccb1070468
Author: David Howells <dhowells@redhat.com>
Date:   Thu Aug 14 21:45:50 2025 +0000

    netfs: Fix unbuffered write error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162dc142580000
start commit:   5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16828c5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c7805980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Fix unbuffered write error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
