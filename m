Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD931C567
	for <netfs@lists.linux.dev>; Fri, 24 Jul 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915706; cv=none; b=p2PBugWEOVnf4rVqO5H7RmxmGl0mj1Um91eD1sJPH/HxX0m7pK3VgBWj9X6Q5CmBfNmwkdObVwjBKBVfQ9VCpUUSRes/HQz2vrAtGrMfOLHVl49q8pF2e2mcnwJQxNk464IvAjfutpog2oMs/wYqErnsCA/E6V7qc2Ia5ZDdS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915706; c=relaxed/simple;
	bh=4ZQw4mQYE3b+kh2i4MW1K5p3jPvTgSZxY+pQz47zUog=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KV04+uRgyB+51/UY1ZZKbW8rsjJwgfBqe72lWXqhLeitQZ5NyL74+xnIFfFfScJvK6lNiroGvSVEOrNe85NblNwcBa5iAUVc0KzsksfhV5EeMq+qAZSoyC7DAdZwGWxQQW/YRyuGoJZU8Qq3NlvYdfatJzsalTZ8Ofc0ZILnrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-448bb8bcf38so506481fac.1
        for <netfs@lists.linux.dev>; Fri, 24 Jul 2026 10:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915704; x=1785520504;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+TliocqPorFGnMueSuU8bG6zbOLvtmBMPJpXlFXPWu4=;
        b=MfMu8Pc8SZLe499s2JlkdtJK6cT241ULen+hG7g63vLTLiQKnx3tjFKzsIXrkyfhCq
         EwFETFi3UGfyQMNeTRT6/REC/CznpEQT8hn3ib++7CGjCgH+TL3GqBtCWIyzHruTq6Ib
         AdAoSVnVXbz61FW8WT6+vO87fSNh487GJPFaZNIdbUPpEVkAL2Sl7PAVInJ0dTmM4ROk
         pUCvFWQpJhQw6KFQCnBe6pMLmMVVc8idzIEUt763SicV+uprv8Emliki8ZJYR0cYbum+
         NQe6zDmkk96l7XPzVeno2vaMN3JLJ7Spcsolv3FoBudvKBLt5hPD082Kk3hI7Mtglc2p
         wo4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrIpsm8HkwfMKdNm+4wOAaxQyKIMdfDpMjVbZhjYTulXJ3uou1a+Eebyj6nBgXhDyCI+745TA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyblU3Zv2jaorDi4nZI3w4vHm7q1F3m5sYmHEDjyMQgy0Ae0IuW
	+XONLnlWpCIcRg8qi38zsMOnGMhJrA9M6KlKX40WjoP9A+ys+/zqeQ/7SDwe3fAwxzijMmNzbiB
	tNb4OZD9oP1VdDaWxjGniyu1jnYqhcTiFAR1dIHD91WE9ZkaTd6eACFklDwk=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bcf:b0:4ab:2abe:f031 with SMTP id
 5614622812f47-4ab35218c32mr4861986b6e.6.1784915704082; Fri, 24 Jul 2026
 10:55:04 -0700 (PDT)
Date: Fri, 24 Jul 2026 10:55:04 -0700
In-Reply-To: <831911.1784889103@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a63a6f8.70955b6c.323240.0000.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
From: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
Tested-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com

Tested on:

commit:         48a5a7ab Merge tag 'v7.2-rc4-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170632ea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d69870d5e052935f
dashboard link: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1377aca9580000

Note: testing is done by a robot and is best-effort only.
