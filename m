Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A119CC1C
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900507; cv=none; b=Av4knC8OUj6XSsadF6Dp7S9+pKOYAmhr3Dov3+H35jDOMLXleEIO4mL2hjcCj3HNnfKZNDyrgrSwc/W+cCg4KYtjzFdQOLD8LczkcUFDKt65bhqcHFMWkTxMwdiUJumMam3RlfWmAxNDA61LF9CCEmPpG600qWGUQGSEx0A2RkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900507; c=relaxed/simple;
	bh=GnhFjpEQk2QTU3xMRMxYSIU7Dc+xnhMFHvUYOX0FzPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oKzUsqGZ+ynBSJJvEIeewL3nfqrnlJEgA6aatNwH23QMPTt5oNlfrqDBPbxHFedx2hxqlJlkOTBpj7/uzqlvg7h0ebTvv4OTy7fFefsuAM70fat4cE6cQJkcgruv6ugD/FSsdwA3urQNf1rmTmzYRHmgyMuTQimOzEaKyLhMPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77085a3d7so16179135ab.1
        for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 09:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900505; x=1733505305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cabndGigWtS979m0rIc0e06+sfnwrdqk4oGx1hUPQVw=;
        b=tU11baS3fCFWesSCKsZMvFROdWqW8634nURSd1NpOOXIjMZZidKyTYHLyxTJEfTwUd
         aWYGCWngGvnKQvkK1K42uLRUSp4EMNRowmm62ymtzOYxXebtXEgA1GrtIGd5+sDBajT/
         0+DW2Dgb9JAU7hbWakGHQ7rURmwcXUKVDpyIFfdG5Ro4ulTvNQyu1nKWIRkFKWsnn3XZ
         1AtNhirzkGdP/gMKZSIv18ZMTsD1faMfHuZvLGqAFA8BgBOoHaRbqgy2SNOWPBUynlqq
         tBVHcfMJeFdaJK726pHL+Z5JWy+U3CeNGwCq5gUpBmzv3JOa0x7h2kBFd57uDSxZvqKU
         JLAA==
X-Forwarded-Encrypted: i=1; AJvYcCWbFnwJPfomGMXBZhULqBRJLsyC9OcEBMxH+VrPJjKzkfYptuQP85+a9cCmarnh+6svlcwlsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv95yNOe+mytF1/sHaBNUZkkAsiKgat6HjRLCNmEjQ5di0gOUR
	TTPyVzt0eQlaQ6JZKuxqo9xcz+gHW/GLl8GIc/RLozaGwP6BecobehJrnlA8b99mTlXpc0mTC3t
	9Fh45oeMFkGlmc55/NZ79J+qbVrS1PqOYT7mBQqYyTLzCGo8VZEo0xos=
X-Google-Smtp-Source: AGHT+IHe8uD7Va/t9RghiydunC7nRHm/GXM4J1aMUOaYHKIypML+ORhOP4P4xsuLh0/azcIVXHk232/8no/NPRjgk/tTxHq54l6N
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3a7cbd23d37mr83760205ab.9.1732900504111; Fri, 29 Nov 2024
 09:15:04 -0800 (PST)
Date: Fri, 29 Nov 2024 09:15:04 -0800
In-Reply-To: <4020304.1732897192@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6749f698.050a0220.253251.00bd.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_read_iter
From: syzbot <syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com
Tested-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com

Tested on:

commit:         2aece382 netfs: Report on NULL folioq in netfs_writeba..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=159cf3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=225053d900535838
dashboard link: https://syzkaller.appspot.com/bug?extid=8965fea6a159ab9aa32d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1328f3c0580000

Note: testing is done by a robot and is best-effort only.
