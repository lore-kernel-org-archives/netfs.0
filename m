Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0621BBBD4
	for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175325; cv=none; b=nHN8RrI+rRLPqsnBPdpuQ6HhZBV3a53/pDqFb6XQ5VmBsZ+MrX9WGDMuSvbi6I50tvcgvfJkAGnv4SK51dAvbLVVVLDuvnhhHaDKNEsI3LB9AeiyatWsMY5NKnPgilfppSSuSQSsDNsyj8Te3dTyZ4KzCVzTbcY/+bmQ3azDIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175325; c=relaxed/simple;
	bh=9u95qfVKYEZf6M88dSEifsWoCD8sVYPu1+QrOe8tpdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f3nJgEmkMYg0rk97htRvBNRtlCjsjRtfycpkgiXyorY6l4sXJZNbivqumggFCvSXD+J6EVHz2kMlNgmmpX8sB33Qk4pvmhyAhyCftHiMkpdxBLXAzKlhesvQJsqFDlsIFnAEfhjKs8iEk53FNtG+VtYPmnPacE/KNmo+CNOx7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85d9a52717aso211901539f.1
        for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 08:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175323; x=1743780123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1mo/hCOtE3isFlkNzr3KUW3jS8AIZP6mXHPyq23eY=;
        b=UOfYE6pe/Mnipn1MwRAK58CGiX3OhN0zJcP9f4i4EX+5EIfYMuxfgylQ0ZgQXkKkJI
         ICPY+aAWuU6CqXAFLdlKYq4jY0SVioPXXfnTEtugL76YLuRBtZED01I2hNMnIGU7ULkf
         APP8v782+TBNjLGOC2/u6K0kvtqemtX7wpRyjSqMAw6KGiIu9B7d7DLB9NHcjS3li+Pf
         ESwdsYmNthVj6VaGawZ991W7/ehNZk5NK+9p+5QcKU4X+Vog4gQ2BErMM3v1pSGzcfN4
         H34NQI9Z7vX7XUzvqVqnrvPNKhuXCJbdPGx8S1DXSNP715QtejutZc8/inMTOVIVeys7
         zjHg==
X-Forwarded-Encrypted: i=1; AJvYcCWabc4kAbIzA81a+XWYDvsZYAwlvS+Pv+xqvIxhXGTFqII+15rd3mZN6MMZhDLtvsGXB8nyPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8d1l3p76eTBomyTmjpyliZCYVIAd75L9TZ+gMkQJlmRv7LTU/
	Ptb8kA4xbiX69geVQJok00pg6zWYlPacaQF+kR0N6KBtD0pxktMhs4gu4Y4Cf+aJ7Vl9Iy9LmIw
	e3d+GYByj4+plAyUzO89SFtDh/CQsa121jqj02aVlZT+BOB7s91uIZAs=
X-Google-Smtp-Source: AGHT+IElOaU5aRIupz74EKbuSIxjuKtTVjRX81gJc0lcI6gjdITkNBPpSaXxPL8+zRjuYGJj3QnRTP8hXZNuoJpP4xv0FZKbVDAc
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:3d1:79a1:5b85 with SMTP id
 e9e14a558f8ab-3d5cce290e8mr94000855ab.21.1743175322807; Fri, 28 Mar 2025
 08:22:02 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:22:02 -0700
In-Reply-To: <20250328144928.GC29527@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com

Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1598064c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16682a4c580000

Note: testing is done by a robot and is best-effort only.
