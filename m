Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A819359A8A
	for <netfs@lists.linux.dev>; Sat,  7 Mar 2026 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772870405; cv=none; b=Pj8ccxB712/VVzFGIZPQrk54dmRMcb9HWs+F3a7xWgH+IICfXCnVmkMwl64AMW/oEoUGrBYQX7Cf3rgU26Hf324EJQAN0j3gd6kDg6nIZmsvWklIqaxWDJdo5mnKq/ItQKOLE56oNtcThZWJd+Y5EW/MnaQUjPAap6V9xu+foOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772870405; c=relaxed/simple;
	bh=ahR8okVFg09x+dFpjVpGySK9pYRG7ZHPfyoaQbxMt20=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q6Wk6SoYH3UUNa2NIZczkXbcuayuwdD5jLck+aEwb36AMFMVLU/fNTtAesqMuf4sdNDDjEYSNJ3b7K1tru6Nx4e/34kCnATZIy2uFleF8MXl87Vbvzvgd7G2Rdau1c1zVGGsZNnWudgS2NuWTH/SWRO7nXMrBDKZY1ZqBVKtLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679a409a175so154679883eaf.1
        for <netfs@lists.linux.dev>; Sat, 07 Mar 2026 00:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772870402; x=1773475202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeYFU/cwdUHyWEw8Q/UgeICTLzKAyu8PtvzLTjGtZB0=;
        b=Hx3MNpeTn786B5I2NwPrhF6UepV7VEwDc4OycACCO5RTRGDG5XyixQeixfx8Mp+/LT
         7+fZLRSLai10dJru1UNCQtPCLCp1WyxdApaqb5xG3y259Vfuhdonxhpja2Z8mz2MovZv
         gGddPsEJlkUbo3iOxM8/RW0/9WUADSrZy4FOrxNXA+quRK73ZXNWSj212FQbrIKgukC3
         Z9xc7X+/0gCelPcpMl8zbpULkvcAhG6Q7JMGTwc96lz/voPOG03INTJ7KGZSE+IRg6Ne
         tl7+V75rR66c9mEhv7/xH9uIIST4lhtzZEKD95w84sIM/jNrCzmAANSsIP+Lg4cqgHDa
         vCOA==
X-Forwarded-Encrypted: i=1; AJvYcCXwM54si5t9RrB3eAgtsM9g5XRXzxAq7Adi3BzklJInmckQwYHLaCtHQTrWPw/c6aN9Ml17YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxupjw/Uu6ssM17iZsa0qsALYygr5p8CMaiFaCy2lqD8g8lFX6Q
	VexBDJMY1qPpG+IvkBnIh+9nM9NyncRLhpGBXW3BsIc7Q7h7RsKsSljb584WpizG22mhQFUbjtF
	qoL++UUkITOUbuflNmjg64xb6Up89Iq23a0dPS3+34lky2ZKTF1kpkD8qgRs=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:200a:b0:673:3cef:fc1f with SMTP id
 006d021491bc7-67b9bd1aee2mr2741470eaf.38.1772870402040; Sat, 07 Mar 2026
 00:00:02 -0800 (PST)
Date: Sat, 07 Mar 2026 00:00:02 -0800
In-Reply-To: <675785.1772868420@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69abdb02.050a0220.13f275.0043.GAE@google.com>
Subject: Re: [syzbot] [netfs?] BUG: unable to handle kernel NULL pointer
 dereference in netfs_unbuffered_write
From: syzbot <syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com>
To: dhowells@redhat.com, kartikey406@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
Tested-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com

Tested on:

commit:         c107785c Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11d4db5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1464db5a580000

Note: testing is done by a robot and is best-effort only.
