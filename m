Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBE190485
	for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743136987; cv=none; b=if6B6/mnYwpJ/O9L7pO+aF9nz+3TW5nuCQUoAqb8Qtfayh9a0HkarUppoqVRxOnwm0YbMp24Zzqlwm4GQriB8dGYaWVLvWXqNFD8A3cr1vK/KOtKOxA6nO02lamyoDIx3Qvj1Z+Xu9FW5jDaeUXD6pMkpjtDL0uEGiu1MFrAcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743136987; c=relaxed/simple;
	bh=js7lVUj/SeoCBiYflPxyZS1OX5HQtjm0DSuCarpQVOk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AWIJ0BEKMqDLnix+lrIxI/DUVBokmbGnK/w65owg4Zr020keJC7y8Gl2pruoUg2bEc2ZQQMPOA9M+8bUgsbvWogWJCk+QQSRse+TzReanExL6MQ4/hWW9euMToG3MiZSsGblu08ZvYtqlq0DGpb1lysW62OCdX9tJg4n8TPmmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d5b38276deso31873085ab.3
        for <netfs@lists.linux.dev>; Thu, 27 Mar 2025 21:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743136984; x=1743741784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uDB2tY1hUjqwKYCX0GkGa9GQ8Dhnk/SPYhijdcB1Zw=;
        b=MUqwHU+mNHSxnDw0e3poDoPpL66sOy5O0f4wTGQBLdidVKdxCYge0AywMYTXBQtwlO
         +OwqYkAm/P/ZmEyto2vSeqM1XerU+umJDh1yQ/D+9uu35cFkpAvneXCOEa8G4myVB8pV
         SDMoDS8cXZUFT9HOZoP8Mm2vaFP7BcEr86ElzAzNEAaK25liuL0AQq6z+vrfYoliovJY
         4je3zV00ASpDFr7UvojH2UtPC3lY5efcvfx1SYFiYHvfdBjGMGaIa4fioAiNKQIcJ0oh
         G7BDQI6BUzhyFteuPCAmTV/9ALGERwIwVIea0Lg6oVT8/eXlCsF+Bw5J+kCjqabB1xl/
         iAlg==
X-Forwarded-Encrypted: i=1; AJvYcCUgTU6uR6CKx4JY1edBoqM18nOn1rr4hDmpeibfNwEh/ljfZS3S1bs294EiP84VbpMil4OCTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIzutZ8Iz69wfQowBR5PtKg2GREa1juO+dtP6L4kFCWArDgsKg
	N3tFtkeE73s1rTPhu25ZF5PqWMCS7tWNVXBp4u9IXcm/R1755OVfPtnlR9mP8Py2EwTfB0PgdFI
	1G0Z7OeDVq06UVyFFdBIfhgDR7fVcTito//HQWAaDiUDNhoLaS5TG0Fk=
X-Google-Smtp-Source: AGHT+IGWgZFryTvbQEfzj3JsavMzFoFExpg1aIjajV07MaP4R+0EXVOn6LPyfYjxRCyNxZA4kryrJUyJ/SpS825l7GjAM0x5LOEH
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3d3:f040:5878 with SMTP id
 e9e14a558f8ab-3d5cce2c7c9mr76000105ab.21.1743136984504; Thu, 27 Mar 2025
 21:43:04 -0700 (PDT)
Date: Thu, 27 Mar 2025 21:43:04 -0700
In-Reply-To: <49c26b3c-cab9-4ee6-919d-c734f4de6028@amd.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e628d8.050a0220.2f068f.0057.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com

Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1285fa4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121eede4580000

Note: testing is done by a robot and is best-effort only.
