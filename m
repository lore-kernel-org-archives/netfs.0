Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00542571B8
	for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393364; cv=none; b=NlncM0FMM6RRYT7dlzyYo5tK/7ypO6aa5oQU5N0UJnI82zj9h0KSVjw2maA7o5KpWLNdcW91LIY+wPtEMxaMEqfzbnvoOhr2xREQrsUXc2R+9cYJifk863qplCa4mZaUCGqw9wj5D5SJi94W4tHC00ZhVn/ixMjPP0JUE1tVFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393364; c=relaxed/simple;
	bh=Av1nEaZBmzPeHVFU/YbHp35FNcszR6QBo3/rp5SvLaQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EF64moB8tWHyrBefGYLsFRHTDmzLLmqZHecoOeOlmrZlQR7EPoj0Yd5JOGY5AOGZQroNOSkWyKfT0QkPdjheTYK2uIZ/ln0t/hhLn8jR7JeY5FwsLTe6B3mz+0VEJT3ILGMBtxEQEGf4NLj1mmS1lK2yC+s9xfWhjzWgW4OYrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e74781faaaso2840082a34.2
        for <netfs@lists.linux.dev>; Thu, 25 Jun 2026 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782393362; x=1782998162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7VMIbtiM5CsO8L6BOnyEVirILtl8EPmlTi0MLNnwpc=;
        b=EO/gmg4B9n7W5/D32XT/aZKSjvArjrFZ6deCsqEU+uvU+27xKCFH87RzhcY9s9Tgr5
         odG6LyyZozRUUc/V8OQwI36dAtNFw2jn+nBJjeFJfBeY8TF34kk0JGbi6xOdCevJweaj
         vLRHxauRDVT4Ii3B08jXm25BY7uFEPQJvA/meEPUWYd/hZwWomGGB/AXQZ8qbgHSZ3xy
         f0Pj3baxYJQYJmNzBzyPE0DJa3NylKRlerOostOW3zIP+mVFO+31LTPAW0+c+UkyeGxr
         OTWTAP4W7UJlaxGpdba5GTroEptAov2lM6dRUUMG3qnoPXPGIOfcL+PSt8N5dh0tIDp7
         FdBg==
X-Forwarded-Encrypted: i=1; AFNElJ/FD4Jrynb0WRzH+Aw3AD1iJ0WNvTbiexEd7Yz6/SDiHzJSHhtlwARE6AcEO2RUNDi3nnTMEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVINd0aJ4DYUHfkj3N+BBYYiPQJhOUqyABf54GoM81lBiWdf3f
	ThuVRbiICV58XZFpqVSAGecm6xbs7aiHH16Joa2ZUw/QcmILhJi+0tOQWLYWbfYSQjbec4mVKaT
	puBoEnzeB7zXZ8U1WeYjw30PCgNnlb/7zFcZltHHVscMerl/42f2ijjsVO1M=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4c07:b0:7e7:bf0:d84e with SMTP id
 46e09a7af769-7e99c18978emr2870405a34.11.1782393361857; Thu, 25 Jun 2026
 06:16:01 -0700 (PDT)
Date: Thu, 25 Jun 2026 06:16:01 -0700
In-Reply-To: <3106406.1782391857@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3d2a11.cf1c467f.2941c6.0006.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in netfs_unbuffered_write
From: syzbot <syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         8fde5d1d Merge tag 'acpi-7.1-rc6' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1553eb41580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1654601c580000

