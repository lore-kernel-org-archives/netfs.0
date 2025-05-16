Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A421E097
	for <netfs@lists.linux.dev>; Fri, 16 May 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436285; cv=none; b=B8/bSDSm7RZWxF6p6H2QmsjEm6XsaNk2VhBXZnAqhJI4mymxlJOQUZo8ywj6rr1CGhrKx38TEoqOO87kHRQLeAj8ExIKY7TTyi41IL5+MGQjAcnrSp9TfduAQOGIPxN63jTCFqFrXeQ8ESE4sRpFHCEJxr2ktISdriZ/Pl7vmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436285; c=relaxed/simple;
	bh=crlD6hcYkgqUk2VnsMTk6TwuNBRLpWcxydDqwkXANwg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sk8IIimwrRmZwL5fyNQhNXQenzjUlyb8nHDg2ny7zQslJLWJtfCqVXbiSFmZs1fDVU2AlzQCajISqG428d/Hd8ufi2onsOyj71Ruw9SYxYf8a1cGuTGydYJLxuMuRdXOBaSYbl1pX9NBW0sytROrd9jcCe1oel8DWTJyrmRyKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3da6fe2a552so43180445ab.1
        for <netfs@lists.linux.dev>; Fri, 16 May 2025 15:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436282; x=1748041082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkCZy4oAbX25iBvlsArzBe31f3vDYggxaZVFFGZRboo=;
        b=k7Nxx+6ErbJNkwkLAU6z0s48CU/29GYWdI2bhshzBPKbm6hOIETVsSZRt8ltB9m6J4
         YCs1L/D2/EjE+hWPFbiVj/zBBWaJftzqyS6gNWSYPPG7UWxnddAe5YET2vX+EWpCFr0S
         CcAI2jRg4+2gIoyR4Cw+Vye715GqOB4jgtkGma2NtO5PC0uLH6FEqbwPiCzqLolL4Nfs
         xZ0dhdWqAswpwVdfSRdt7z6qCTWGL4oJjV7JWaaLqOWQMrc+OoNrI5L3vpwOlHw9Rvwd
         Qb4FHRlP4sYVsEwj1SnLId3G+3I94Xt5qse48PPUlz/orneioh/V2Q9bZ6mgNbK0CrMh
         B7ow==
X-Forwarded-Encrypted: i=1; AJvYcCUwYKH5zbyaoQkyhldezx7q6HH0AuoGel7aOfbx8u4979abrjw7XRDRaIiZk7hqb2CI/9VI5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvEl8Y0/psFbUsjNvlQDuLGMAx4WcbyU7qlO6J45cfrOSD8uGd
	Ddf0xtLu7P/TPjr4UIxxATcSdY6xHYyKajJJHp6UJfT038smdTBJaFstFL0S2W8WncoDjbPSgSx
	3LKVNNkpBBHOmJkinc/or8HBvnk2CHGJVpnCqbC7Acb+eF3C9hHZIXENoxeU=
X-Google-Smtp-Source: AGHT+IGV5LT0uR5Nz7086K5O0wYaH1Zid4vNGxPgFcsJzGd4vSmYuvN7DSZEaJBn3/LkPva3IQ+yfOoGMSc7h1yuY3/yKzxpCgmy
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f87:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3db84324635mr82117385ab.18.1747436282520; Fri, 16 May 2025
 15:58:02 -0700 (PDT)
Date: Fri, 16 May 2025 15:58:02 -0700
In-Reply-To: <2705414.1747435079@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6827c2fa.a70a0220.38f255.000a.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in iov_iter_revert
From: syzbot <syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com
Tested-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com

Tested on:

commit:         82f2b0b9 Linux 6.15-rc6
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.15-rc6
console output: https://syzkaller.appspot.com/x/log.txt?x=11960ef4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=753a0ce88f56915c
dashboard link: https://syzkaller.appspot.com/bug?extid=25b83a6f2c702075fcbc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174022d4580000

Note: testing is done by a robot and is best-effort only.
