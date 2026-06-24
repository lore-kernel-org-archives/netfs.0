Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46722D9ED1
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300903; cv=none; b=BP+zR7ErufsnhlPQxQWzyDYTrg/J9b9bhRrC2PfRJ8xCvvWEvOwRdL+osUKkj5/Jp9WzWoZEm6e6zCPPSN1FccFomn+VNR/cYGBiextI+iPNg3BRmXF7wkwr34Is6U4yXFXqECT8k1tUXpq6rn8m6prOrk28eeuFyrr/OCNX+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300903; c=relaxed/simple;
	bh=KlDFNqvN9e8LADivYYDzOhGSGnhn8hFEWVI67gn19IU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o6/L9QztxJ8qJ5T1F+lZnoycXEngtsDqoGWEwcH0QTeruf+A6NcGBhNkJmOjj5mlNHHEpDRuUA/jUs6wF+xnAVzQnJwZ/041jMwpBK3SoWIQxxX2OYJmdDRXvgYDfIKlNNev7aC9NBuM4Z0iV7cm3g1lRMZgHHU4N8RkGnfs7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6ec7ce0b2so494888a34.1
        for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 04:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782300902; x=1782905702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvE9Pm70gpmoaAxrFlJ/o8U3S+zB4RLe5NXVuDhnvvk=;
        b=PN0/BtOj53IMdnITNWsseL17dpy5rBZVuoudOkuFSZkDRdgZ4agWIJT6Sdh7GzeIXu
         IOFk+N470wK7q9u+0s3XjBXaJNg6qTn3ZOr8irYHVd3OlRmyjsiRA+mS21++6jT86Vcx
         9//K6k+oQR8tcBtE9H19ETTHsgHqoboOcLqQc7IIjLWFf8jIjAT6OyGyw9o0xil6b9O6
         eRtutXp65m6BbxmzhXDMnnjcj/ZI08MsACZNgGXYRidZnAdfFZ5tDewZTuMev1A6pEbZ
         9HnT4Aa3EVjAASL7+e7sfmHRG25DtwcCjiMAuOdv6F/xj6htfhg0coc0Oz6y/axPqBJf
         cjaQ==
X-Forwarded-Encrypted: i=1; AFNElJ91mRWICLKCOaVjtGColE6uj2E7clXUUIV+ADFhyeklJ0xoGzr8PfSYTY+hHAo5r3h54z2EPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBGz3ILMX7Lz15I9PNMRxQsNlAY6Qw2ev1iq+kwQN9S5qZx61S
	MYL6rqEHptn8MF5PKKU+G64L+uW4gxGEvLztfVzy01BOXmwUXOh/L2cQkeLh5ORWZjIjh818ee4
	DwKWlhgTApnOGdKu8BO/NsTZHegRptAk5cPzsScgnDoujtUuHHdfR1Wp+RUg=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:690a:b0:487:57d9:9d1c with SMTP id
 5614622812f47-49077298b49mr1819793b6e.14.1782300901672; Wed, 24 Jun 2026
 04:35:01 -0700 (PDT)
Date: Wed, 24 Jun 2026 04:35:01 -0700
In-Reply-To: <2961584.1782299080@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3bc0e5.92e8a34c.2b91f1.0007.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in netfs_unbuffered_write
From: syzbot <syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
Tested-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com

Tested on:

commit:         8fde5d1d Merge tag 'acpi-7.1-rc6' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=179edb7a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1557d766580000

Note: testing is done by a robot and is best-effort only.
