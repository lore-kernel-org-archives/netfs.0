Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273B822066
	for <netfs@lists.linux.dev>; Sat, 30 Nov 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977845; cv=none; b=fmAPNSfG5y9HBrLcK8K9IOCbRsQAOdG+gPTXQJnQr/ztm0LNnoBMzyeArn3o2j2KhgSOFTZiyeHDlsbHLKOqbVW4YocTMrAvGWwA7OTq7oxpb81b5HKjSEDQXiFgI+Tlkp5buae2CdlkPOkaNPHUev/e8hgaQM99yrwLN/6E+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977845; c=relaxed/simple;
	bh=/2me3GlS88an3RLsz+gmPqqJsjFVKRchDVf0XYxw0yA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aaO0A48CPT/ET77ihaBYNMJvgHTeqGj6OXzTHPUEiUDv8s9cIt41ded7blnQhDP5FaxbCmDhziBFFjCbZIjEGhuHPZUG934G6Gr/MBJE99OJ3qeYys7pBlvHYCsI8nyo7mZqq3ErK3e/nrh27bz7jJ9fmThgyhNttBcvN8Bx5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843eac1b9dbso251087739f.0
        for <netfs@lists.linux.dev>; Sat, 30 Nov 2024 06:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732977843; x=1733582643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLpCxVWUm+FLHYgY6UmUs8QAXQBwFoHMQc5QOpBkoP4=;
        b=AlFokrBoRY6sJyFWzrfXo9BXYkqWdY8tMr1yd5t353CIxqXqEiptGPVDH6o2dbgBJ1
         A35vcip4Yr8LHbmYvdMQmWXzOXm+m8NA9B2G4SyLim9Qxe9ZU5N3iNQdAiI7oNif30S2
         5pJZ6gdx/1aXQKFC8+M/AatFq1eshsUJDYmbWCoGcVV/i9mTBTCKsJUE+xUfPlh6aBFK
         CFK/LYZCXpOg3BxPlBy/RQ8jSAcvawlScIPWfpaysjRdUFcXyiPM2UwLOpNbQgY8g+U3
         KdP5DEDK5gzyRxCza9UaFL5tOn0cqqyZpPhOMA8DCdr7S2T0p5WiGiYzP2PhVVo/R3dj
         bCgA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Yg1SWtzCNY7pRjt6ZKigIzsjpy3geD1xZHDcwkDZApemvNie65OJzoKh/C5+zZuSvAnpRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFhBsolLJLS2OKPDN+wMV1UAjz5InBnTv2sJpXxuyPm4q+ErgC
	FEfUPiCsmNDgH04VoxK0uZ95Mu8AlT/6n8W5uusnoALXr0pQNaOMb9Et6+OSwrlIxM9K5iQnQEm
	iy2a7aE9REjhVGtbeDVINmFTNIH1izxV4i+JeaKu9JxFoVBuTBFyW+HI=
X-Google-Smtp-Source: AGHT+IGKM3IQM8HG3HSI7urzSPpJKTU55OY0Q6Z5kYb4DXB4yN+jXJMypP7rSsTOQ4NnPvpsotgixPfEKNRfhZjHxhSEQLvvMk5g
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4405:10b0:3a7:c5ff:e698 with SMTP id
 e9e14a558f8ab-3a7c5ffe892mr96045695ab.0.1732977843441; Sat, 30 Nov 2024
 06:44:03 -0800 (PST)
Date: Sat, 30 Nov 2024 06:44:03 -0800
In-Reply-To: <67238110.050a0220.35b515.015e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674b24b3.050a0220.253251.00dd.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, dmantipov@yandex.ru, jlayton@kernel.org, 
	joannelkoong@gmail.com, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, miklos@szeredi.hu, 
	mszeredi@redhat.com, netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Thu Oct 24 17:18:08 2024 +0000

    fuse: convert direct io to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e29f78580000
start commit:   f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10129f78580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e29f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131f71e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bc200f980000

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
