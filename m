Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBE1F03D7
	for <netfs@lists.linux.dev>; Sun,  2 Nov 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762105084; cv=none; b=Z9WSir6KaKFE/3g+Z7j7wL9VJEWKvmFgiKdwc6uMmQf+cuoAp/h4CJKnKD8SWbM27+kW9lpUXLJsQcByzJk5VdUBvH4X20vrJHza1Oz5JZe1S5UBev7JkOiXrMUhD4SJrKvP34XDjIeoMyYeIzdx+W8ofqgi4YdGd7+GMqgkDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762105084; c=relaxed/simple;
	bh=o0FIdqFREk++l3J1v2J3tW9h4pt95Mr7/7IG2Ece5Aw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g7G4pRLgJkIY3oKTRvx00gZwRJXlRHI9b23b/PM+OzI56CvfQuVL/e9fRwX0P6iPAbrGcx+wkQyDpjDDt/klhMKSJoaoSNqMGaiDSvj9YHv8jo+aMSKSkFjUyJsJW/1eJ7lTnOA55eWpyAYhWGrS/1GzVi15vveWTK618vBMvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43327c30cb1so6854295ab.2
        for <netfs@lists.linux.dev>; Sun, 02 Nov 2025 09:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762105082; x=1762709882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/wAEv9GIPrwh1+x/pr00cLookNh43MVdSe1H945Cxs=;
        b=hCgL45XdGN29mhM2RxFW5kQ6BZZ+R9h9YYcQ2xEi8EcwzFd6YYLZxFBexSGlcB5Qne
         hEIlo7dR5v3J7RNwQMxyFHu7lI7l6+XQBj+Tznr1gmWWPnkjqnqSCklpBLnJ7e68ZjJ5
         keTSDE2KdChVa+RqlRJMdzUKy7ysEB7b2p6Fx9R+feiwfMoYY6jAGNS9jKCl+UXsKig7
         T3hpeZLUe4CyI4XLtOavaiQ+abFuJEYIC/xsJSKIddsQGsJC5Lj9GzsXhfYqWUX/JrIr
         0/WsV99GJiM2eb22pgheAj7V68R4hyNgaiVUcjCN7WBhbjoRnsd4gVCOkR/mXFYSmgyY
         MRYg==
X-Forwarded-Encrypted: i=1; AJvYcCVAbUegM2UN6Vo5Dsgnm9yWXAJGSPevGUQtZNA/Gdi1BFObxAsVFnNe9Ze26AMu3p/QMzjfqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDhHf6YSD/UuWdVHsqPWLw6eDnaKawaO1dE2YpATlM1BqOtfdi
	nEpptNc4ZRHsl6B+vPxdhnBhL8R6NU5Q0moCWmsjud8HQbSyEclCKahFgHGMelCaavpJMGUeA8J
	LKjND7zWTY9wwEXZ3hmSXE6d5dvtTPmWFBI6fG5e83Y2+EZVUl1NdwDoufoM=
X-Google-Smtp-Source: AGHT+IG1zgigFckBfcGNeJaiPbJX6Gh9TmGX80g1LSF0Ct9iysgCECfpHX/faSxFEexyhP9Nc8O6trkMpNHWl4XussCMo5cabh/D
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8c:b0:430:ab63:69d6 with SMTP id
 e9e14a558f8ab-4330d1c9e60mr128484625ab.21.1762105082195; Sun, 02 Nov 2025
 09:38:02 -0800 (PST)
Date: Sun, 02 Nov 2025 09:38:02 -0800
In-Reply-To: <67b454d4.050a0220.173698.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690796fa.a70a0220.37351b.000b.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] [netfs?] INFO: task hung in pipe_write (6)
From: syzbot <syzbot+5984e31a805252b3b40a@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, gregkh@linuxfoundation.org, idryomov@gmail.com, 
	jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, netfs@lists.linux.dev, oleg@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	viro@zeniv.linux.org.uk, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e8fe3f07a357c39d429e02ca34f740692d88967a
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Tue Aug 19 16:10:13 2025 +0000

    9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154ba342580000
start commit:   ad1b832bf1cf Merge tag 'devicetree-fixes-for-6.14-1' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e55cabe422b4fcaf
dashboard link: https://syzkaller.appspot.com/bug?extid=5984e31a805252b3b40a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170d57df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12df35a4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
