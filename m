Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DB1DE3C8
	for <netfs@lists.linux.dev>; Sun,  3 Aug 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222944; cv=none; b=LoAZFBcFBkUgqGMb9+tZT1ZxMdqcz57ugrMjPuHOHlROCojv9sXUFNetWQzRR2Kggon7hpJhKSmS4s4wOvR4py0rz/2hosGj5Bt1aR0+HgKidu7g1ysQb+N4A7j9ZAa3WrI4dmlWQO/SU+Au1Sak/UATsLRIdErco/iSvRVK1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222944; c=relaxed/simple;
	bh=+BxCQVXtTe+xoz4eJ9sHAveL3+qt5++cybtEn1AaG/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l0UJweqXPXCuFM/k4G2gkuyOWVXchBElNuGT5JCm4FjiiQAmBoWa+08sRv3X8OB1aMMtUn2/NyWFkaF92Yy7PW/NzSSkN5j+L9SGGD7MvAiP8Bm6tugsZO7bLj+Lic0wFwvsBc058g1MxzqcTv02pNTrwy0pCuGkp8M/RgtmBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3fcdbeb23so70022805ab.3
        for <netfs@lists.linux.dev>; Sun, 03 Aug 2025 05:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222942; x=1754827742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5+xCIY68eQod8HShjZie1OqXUWvIMyxZ5G/valhey4=;
        b=NVgl79LVYqo84t8COzYFtLVrynEV2CwqGn7VsmcoCxOEGV6MVCzzpiHmTo3uHjAOmR
         qCsYi8KUMWe88Jiu2eZ8W+aUeKAlrt/0kZTUA6n82IRwlpzb9BQb3U1X5m74GojXUcP/
         GQOi48H5ro7hMKXubVQbdIGmU2jgT458t41D2nkoBGCeXvxa1pKOeIfIrTb0VWNQZw+M
         iXfl191VLBW8n3EnBOSywZ/9yhks0yCMyRk5RLF2FUeE8PUVgbzC3mZksKUgoATzSQOf
         GBt6triHJ7w9OFIyTXev+D5bLXHdE+LcYGUlNU1ESsSUjrL1U49ZfdOiL57ftIrlLiHF
         DZVA==
X-Forwarded-Encrypted: i=1; AJvYcCVOUIuv32zAnFaQQCLoVpTc+rtLnmVz4DpUstWTWa3VsOPyvFuAEFnkcQpx6wCX7CCzPNMU6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YztsdP4JW8eHMEoickEjTdgAaGx9mq7XZDFKK6+BK5Izvz7AT31
	GaxnyNCTgAoO193sKLA7N7pfP/nZVvmuP94M/L3MDBjb+3qaAw7/QMmLfXCiZRYFEw/mruPX+xw
	KqgAcpjbYfceX36YJdLjO5C12Eaaqv0umqFdBP3+YSzhD5+9+RWDMRDyZGfk=
X-Google-Smtp-Source: AGHT+IEI73yOX7LuYSonRTZStd7VDhDxkqzJkzexmNHlJCJ1YhLhqOvcqAg6Qh64hhfeEztD7/M6cYE5zqbG4QmcfI8nTwAfsPR1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3303:b0:3e2:81d9:cbbc with SMTP id
 e9e14a558f8ab-3e41611a082mr111370915ab.2.1754222942254; Sun, 03 Aug 2025
 05:09:02 -0700 (PDT)
Date: Sun, 03 Aug 2025 05:09:02 -0700
In-Reply-To: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688f515e.050a0220.13f73d.0000.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	eadavis@qq.com, ericvh@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jlayton@kernel.org, kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	mjguzik@gmail.com, netfs@lists.linux.dev, oleg@redhat.com, pc@manguebit.org, 
	sfrench@samba.org, swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit da8cf4bd458722d090a788c6e581eeb72695c62f
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jul 1 16:38:36 2025 +0000

    netfs: Fix hang due to missing case in final DIO read result collection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cfbcf0580000
start commit:   66701750d556 Merge tag 'io_uring-6.16-20250630' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e29b8115bf337f53
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1400348c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b2048c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Fix hang due to missing case in final DIO read result collection

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
