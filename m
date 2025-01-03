Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2B1BEF69
	for <netfs@lists.linux.dev>; Fri,  3 Jan 2025 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945899; cv=none; b=E0RJQ+6Y6xg+sz230a39tQeQxVzem8QGTFvhFS2WhDlxaMHddBolXUu8rGsTI4eJ3PGIlozrXRxIT7a3Jzmu1UXbEb9226yoCrHuoK7PMZfPHnvQeeZTh1EyR1WBQeiHe5HqcugOgnFLa6lFVr6Y4FQ7EQOwTabdi7NftJni+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945899; c=relaxed/simple;
	bh=jCqN1Wkyb/pLojOb6/3V8BZ+ft0za0KaNr4VwZwlbdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZR2jLseFoXfEZgcvfNFbk5q5KmsNOYL2LxnZJGxk7HjfeBSzqbTVRogs2q6xIzfKPT04Kvi36Xi5nmHMUsBlHkBOL0smshgf76CwtwKxgaFOv9vidCRydyk8xmYeNlwqnriCG9W7GH3iMG5SY+5K2PEHUi4OBMdegpqtx+FiF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81684bac0so259547005ab.0
        for <netfs@lists.linux.dev>; Fri, 03 Jan 2025 15:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735945897; x=1736550697;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCqN1Wkyb/pLojOb6/3V8BZ+ft0za0KaNr4VwZwlbdY=;
        b=GDk3Dk/aP+BHqFOulWFF+1wjZd1ogN4QSFID7PUgsTsKw6s93MBlhWg/f9c16wvsqs
         /aYyBl/X+1GIWjaAsqzSdRM9luL2fWphGlbhT+e74VPxH1juy3OeoyOIJe/IUvH5mUEZ
         sovbHYWtZSXin3sQWlTRjxxTzL7sdi7XNkopFALrO4N5CcLusEChlAO42vhUBsG47QhT
         nCNp8EeCilqBmXflodvHCQ/uQjdBlwyeLMn3VDgyXm6mWteSGHCO2dyiJGkvOoIMXRTZ
         E9snv5lcwmK0BlNEOA2CIuq44UZFCt6rdPwz87QjfaRbqqngoK7D8e+NIAQCUFDWH28P
         M/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWgzVAGSa6+UrGcuCYHT+sFB6gPwgWF4qrVRSWtxrvmNK6e3Q131nzttQ02d/F2p1B9gkAgRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUFvmHeOqnFd++rmG1tYwTVoD7bweo3kpBMqmOaPGki2TVyVFY
	D9nmmtgXnxxIhCg/F9mn9JOMXc9kXWretmHRKJFAvGb15+UbEgQi/xbkmW8UrHZkOPsu2sGeTqA
	ivIVd1KiFdvldRKLZekrlAK0ONc9Lhz+3rBot9iywZ3aKRfLQmwdZ0OI=
X-Google-Smtp-Source: AGHT+IFOpzzcVtSGjl2YcYkUd+APZpWzYsM88yHA6me+VNzS69z0kbOmvzrDiPTyKkPMUAIru9KbbPA1Q8fXui3RpcE/mAiABlvs
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:3a9:e2f3:8dc4 with SMTP id
 e9e14a558f8ab-3c2d5928edcmr450473375ab.20.1735945897220; Fri, 03 Jan 2025
 15:11:37 -0800 (PST)
Date: Fri, 03 Jan 2025 15:11:37 -0800
In-Reply-To: <CAJnrk1aumuyz9J1ZWReB+diDXffRQFr1Et1UMoyyuBRf+s272g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67786ea9.050a0220.7f35c.0000.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
> <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>>
>> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.=
git
>>
>> want either no args or 2 args (repo, branch), got 1
>>
>> > 7a4f5418
>
> Sorry for the late reply on this Miklos, didn't realize this was
> related to my "convert direct io to use folios" change.
>
> I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
> fuse_get_user_pages on allocation failure") should have fixed this?
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> for-next
