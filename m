Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24618E06
	for <netfs@lists.linux.dev>; Sun, 11 Aug 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416184; cv=none; b=DdF40rXwXjjj8xrK3dtzuAL9TZU0oxK46byT1878KwRdLC7UgDYBq71VBk+dzy6h8pg7vJ7d70ZhJdMSFeMu2DtJLpUDtsdhbA4+reNb2zDIIwlRScN86hD9LxY1yLd6k1DoNKUIkrd8ALWrIVl7lSH5FFoeCrh4AcWL8PQSPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416184; c=relaxed/simple;
	bh=L4Lv+V3TAvpIqLu3MSz4+YFRq/dbvUKkqeQBE+ixKpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uRQe39dxrJIBpEBACkFU8Gm4BjTejfsP4IWcggor0riQ4DaK6koWQtJ/UkEq5WMwdEPuJR8IQqpjcKhaFpv8ULz9CrHvahjkKLu+wnx5aYYLkpn/aa9JdCKLJbt+66XXIar0YOwCJxKxuONSXnHvjrQPW8wbyGFzT3gBaYKzVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso48427625ab.0
        for <netfs@lists.linux.dev>; Sun, 11 Aug 2024 15:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416182; x=1724020982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVqFzBryEujNvLyT47tPqWQBFIh9FtkAq+KHfk8fPj4=;
        b=ocK+KRcXnRHTZqA7U9KFAb3q8NXHVonXum79mfRwoDks+nC3WTmy6fGw6gSItqpeU8
         o6PR5ja9PCjOKOPkLEmIMv+ymGVdcDZ3ScQDroxvHDRJ6MWvWBLIyrPObMCtZglVCkzh
         PizKkvUCMWbSrGEG7n3u/UPER2poU3vQ6A3/VYjh5ceRWXzGGPRlCfognlMLHyOWI2bc
         6tSnPiUl16tUYef3qmi/618iamfq8krL7ux4DFNFHrrGIfeS791lPI+M96D4Gf2KFyvw
         xYO10mFL9KmpWroinE3K2ZYCQX0iVqGaqOsv0Vlibx5IztNfYt3UfebTX8c/DPEFs0Wr
         Eglw==
X-Forwarded-Encrypted: i=1; AJvYcCWA4qZEg0HGEPyZ5el1xdT08ic6084/+umtvkk9QfZhn3IdLLc+qkBILTXr6k2lTxIC48KbDdTH260gxlAXST0SA0WKK8Y=
X-Gm-Message-State: AOJu0Yz0pVIoS7betHqydrwQ4iSlsxf28AuJbOG9WkZJfgafhv4V8zLu
	4Pz7mGXrpBtLNrSNvCPSObkF6JijKRgBP2a6Zs+690Ppa5XLzaQC+pvix4b1qk4QWx51gRxbgVx
	Fm1HlocNhtqJ4v6sEQvIgrKq5oMHHMc9m8QY7pvwqFaFTLDv0sC32nd4=
X-Google-Smtp-Source: AGHT+IF7jkF4oBqJtIkn6QuGeZP/SaW+o6WVuB+UpJ1Q7K+E62/xT80ADTCE4nj7LwY0M348sXjLlvffGGJyVNNQbX8hhCmM1l+c
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-39b8709bc57mr6384475ab.4.1723416182349; Sun, 11 Aug 2024
 15:43:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:43:02 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005971a8061f70191d@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	eadavis@qq.com, ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lizhi.xu@windriver.com, 
	lucho@ionkov.net, marc.dionne@auristor.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2df86547b23dabcd02ab000a24ed7813606c269f
Author: David Howells <dhowells@redhat.com>
Date:   Fri Mar 8 12:36:05 2024 +0000

    netfs: Cut over to using new writeback code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148b014b980000
start commit:   5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168b014b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=128b014b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16828c5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c7805980000

Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Fixes: 2df86547b23d ("netfs: Cut over to using new writeback code")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
