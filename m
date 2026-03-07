Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0692DA77F
	for <netfs@lists.linux.dev>; Sat,  7 Mar 2026 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892725; cv=none; b=cPCj+ekz1N25YGFWU8a6lzHBP0U128aOdst8pdNmhcO7J2HD9hfZVBgBXLvCoQC+/9+unEOkc3dUZeWjumJ6BQM4KnRQQTE8p0oD8MqZXgqv2L9m+RNOlQiXIAx9/5zfutnlfdOxKKARkTgAnra0ZaBFaPc8P8LydkvzyVn5OF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892725; c=relaxed/simple;
	bh=WATbRmx/veztlxbajH6ebmO2CxzS4Ua6ZlttOzHkp04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TBcQvKvMReDZfWMFSlJgHaAlnnL21TJbzLIA9BhIy978eokcDFn++NPNjGGKDNgpxzgY5W1Ar7qDecJ01OvjPeUsIJWJJ4S2mm+UUUkrjC0nMu82Cvb+FYEeIKvY0iMmqqK1+y+tjOng8euJ8cH2YsIpmIbqgo4c7uHLPWm5iUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4cf783c73so139287766a34.3
        for <netfs@lists.linux.dev>; Sat, 07 Mar 2026 06:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892722; x=1773497522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=il3sOCmcrVJs9HHc6eX/g7XL5qIrdkLnxgjrjyiZbpU=;
        b=EgUhCs/n5H8PpWzjMjvw/Ed/8bbMQ4ugcSGgoPQyG63rlHUQI+vn18viGQ2ZV+VDnq
         dcNEu3GuZHLcStqBgIYjyxATsax9WxuH+USExLl1A6yilIwdvQch/O+hG8/ig5N1DDAo
         f77jugfeFN6Ea4QuFAoJy3y7TvIckaouJ1YxCXg33MscM0fZ0uGz/im5/gpyQk8IvBu1
         IlfElnZ3wVsXMN8bappWrcg73SaigK3vVW+Pc6azJyZHP8CUwzpZOuIi/F4RdG079avd
         gO5gOJprhnpWD2v/uY21YSqCPdFv+zfDzWSxHKnE73Gp0GsscsUimgtJZfbFniKsXrd3
         i0hg==
X-Forwarded-Encrypted: i=1; AJvYcCU6WVI9sd+G2cs52xquxiHO3dHnXuw7ziEEn6cVmMtSTGVC/kxu7IqYvMVFp1Uq8fvuREEtZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3tAOyugGgy24hUldKgVvxKLlWaeqp5sHWqNR8IIgefRd36OEM
	UkjDAzJpkc7XcQXK+wJMiUrEJePeVIywo1olfO/GnfcVT9DCVj6gbeBSwqgt/xLGBVYQ7kTQSx8
	jAC1Tk6dImDgKqYIEcFoHkp54HTcF199EkUnky8CIcBc0lHg9aczWSHvSRS0=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2283:b0:67b:a91f:8f07 with SMTP id
 006d021491bc7-67ba91f93e7mr456981eaf.29.1772892722158; Sat, 07 Mar 2026
 06:12:02 -0800 (PST)
Date: Sat, 07 Mar 2026 06:12:02 -0800
In-Reply-To: <683930.1772891469@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ac3232.050a0220.13f275.0056.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in netfs_limit_iter
From: syzbot <syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com>
To: dhowells@redhat.com, kartikey406@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com

Tested on:

commit:         c107785c Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1756db5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15916b5a580000

Note: testing is done by a robot and is best-effort only.
