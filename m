Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF21B4257
	for <netfs@lists.linux.dev>; Thu,  2 Jan 2025 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849179; cv=none; b=ObH/nl+M1X4N4jaZUPZBaA/B88/tVP6dsuaKIn87xaWaODlbcZOaVzMmDftTpc5yW34L0Cnv8f6ijN4O2glOsr2rRIs5R5xPm8rYBo5PBFRNE+AJOEPCeDsJLU7SKIHnjIyolIlK0JSugg2ClW4zB9EOE6anz/7QrnFbZcGo7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849179; c=relaxed/simple;
	bh=0et2PUuVun1y3JgjI0sUvxWxeyC+XVDExzyexD6fPhw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gVjpTD7bZha3xwVF61WPum+1cempJrZt6PmR+UsqSaSMnVC/5VGaz4IJB+peT+UbcwX06ShCijGbqP1Acp7AerxOKevwH/29RkXqtsbc4HPn4k01V3bony1geSYUTsf51fiAZueFLbb9ZrktTNeJo8ZxhtA5IQD7isrQzwc1xWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso109235345ab.2
        for <netfs@lists.linux.dev>; Thu, 02 Jan 2025 12:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849177; x=1736453977;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0et2PUuVun1y3JgjI0sUvxWxeyC+XVDExzyexD6fPhw=;
        b=LvowdkHDyR0kaFFEBe9IaH4WzoS+UgZ0g0Bj8aQKen/CaQgSxTiWVaoMYHCP0hmpn9
         Phm0PNeFBp3UV3hlTU4n2ZrPj0qKJGIHy3f8F/25KQvAF3QFKyIXGh9mP6NnioarbFHH
         je0z2t8ANscjNhX8zlxvvD4M0BbO/V1xaQaxTgKiGh1U4vkKWuiaoTAN4SD+ykpFsEkY
         sLv0TrR8ByOR/gIiWcoxDpUO5D+q/VqFkWa/rgmTQ4O2m5E6EX2hYfxUdGdz4ieXKP6j
         mvCdtGQZ+Bt+iJC1a7VgO/FSIMexhU3IcyG3mfrI+0NECPMX2b/zp6zo+Z9DITKpkIEB
         AZTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+pmIK3csUEXbGs2Ofahi9rKFoSbOw/QyGqTCmgoEuYcB6fGhfslu+r6gzSyulRVNBboMYxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzgs9ypj4Zc4Q6Yb4+rxZCbV3IlCMHHfKve+c3j2gZU+4GM/Q0O
	bEe1z3lLJX2N6GS+2drj1688h9fM1+wepsuWmWy6XurJNZYE/yaCsrXup8i96Op4EIeJnS8jzqE
	I1HwPpePs3HNnjESZQpFIWBS2vvuemgPPYGRjPpNKg0n0ZrlarNP7Omo=
X-Google-Smtp-Source: AGHT+IE5j+MoGtKa9tT7cMlBVy+6yXZQjxDjqR2NWIsMJqlaoPeHVrLXBkCjZm2EcaRErmfHGVh6gIdu7uf+B8k4nkiexmNFhz2h
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1645:b0:3ab:8db6:12ac with SMTP id
 e9e14a558f8ab-3c2d1b9c925mr340133665ab.4.1735849177379; Thu, 02 Jan 2025
 12:19:37 -0800 (PST)
Date: Thu, 02 Jan 2025 12:19:37 -0800
In-Reply-To: <CAJfpeguPw9CsK56RHGTfpYhfh4V5Kj8+JHJJo=hJDy39=RB+3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6776f4d9.050a0220.3a8527.0050.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: miklos@szeredi.hu
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> 7a4f5418
