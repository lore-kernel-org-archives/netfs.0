Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592D1DF24D
	for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187445; cv=none; b=pdT6A2/jIxvuR21OJtzyjNElW8NYqkVJCk5k8KIobUXYlYr1jg9FYppxW/hUjraRl+2pPy3H0nyyaUKctHWr+5Bc1j4ZTYb5rnZQE5TbMnpoRz/qC4CltW4Z1atECVHLHotWr9CDGOnv0VBFoF1pV3oX6TdPWvRokZE1vJCnbUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187445; c=relaxed/simple;
	bh=SPecG2wm/IQkCzIGqgAZ0mzsyrh+xZVxCElSIKvubL4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EwMhFZI7i4H04NJ2w14shJHs8qB+WDu33vUTK5T3O55IijGNhm/tF+lX7hDLFZxlTk7i5yzcr3tz5nUClfuxMWM9SK2H0sVFutfGzZ1LuTaucvTTb3DTa9KC6p8zoeOkdX5C6giu/9HtOMjosi6r5Tu9wPFcIy+WiDKo7nKxLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso29295135ab.3
        for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 11:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187443; x=1743792243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g90s5dJ2ezUv0GG4ZLhmkiZnYoiDPKfC/SO52fRsdOI=;
        b=fqGFCt0BRaPOwRLsQgoueYJcmJ/zkbEegNsg8SfVXo0/Vgap+JvIzwn+S+3RkTW/+I
         T8w5qckvYJmIf0kbUKrrybEcRVKtzLvgLx7hq+B8mvlQznIMvDQAnv0yOP7AU1d1AAsf
         lNMrneIt3qQ6xytnltWyOi90LInWCJ0WJsDCKCw5ciKT9X72NoQi/LbWLM+mf+SOoNHg
         EmEKpMsdcqMco54J1Ib3nZC4otxf/pAjm41hvkqpRHPjzIJ1mIb3rkw3sJZoryw1wdle
         hj7d20i0ZZgBjp8rjmoWi/BqujZIWned+SEkbv5jOHBVeJk2OfrtO5beogS8TE7AyaTx
         0D5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtRmW+qcFvskCBGyWaHnF2zQ5eTSQVQqh7DjQAaSLEc3jrJzkxibp8ZnOyGrTj1Icd7ff+sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxnAqzaQG/J2TMX5vqh+S2qLRGsL0x6sFc6K7+JFJ9Ci0C//c8
	OyFNrSiu4aEwIOZ5qw5W4zGKsqnbzWlCghCiFx2vPYqIU+Jt7aNyayl5MEdnjbXW0Z7h4YrgrBd
	UrQM0XyRzn1fRryes5lNu8TOj4gdFasbUVpDZR5E+3ApHQ0Dvmv03dCU=
X-Google-Smtp-Source: AGHT+IFoCoAM7/Lk0qcdsfAroXF0YLd4ElkidSn67MaROgoMFIwZfHRztGnsixG0Ujvg5uJ9HvohZsxiNtg+jm1cnjPcDCASg0Tz
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:3d4:3a45:d889 with SMTP id
 e9e14a558f8ab-3d5e09cdb6amr5254815ab.14.1743187442778; Fri, 28 Mar 2025
 11:44:02 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:44:02 -0700
In-Reply-To: <86991.1743185694@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6edf2.050a0220.2f20fe.0002.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, netfs@lists.linux.dev, 
	oleg@redhat.com, swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         c7fffb8c netfs: Fix wait/wake to be consistent about t..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=15722a4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c3bbe7ce8436a7
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
