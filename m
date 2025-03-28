Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B817A30F
	for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169745; cv=none; b=rsfoyPA+kp0zOoHwzDwGRav0QIlEzeehKm/FCLGRfn3mER+KruqsIamRdvk86jAKQWWJzJsIaD48hGUq9a/LBugSrNCQFYWIlXgDIfce5W9svIPGYRDofP7qDxQYzUizbNATAZPhVieL6ehL0xkqDuMX7n9Yeu8szqodp4SBt94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169745; c=relaxed/simple;
	bh=ksFQUOP3EzZfL9D4/0O2XSC5+UR6AEx8dV1lPhH8BeA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jDJj0jzXEHX5fzZggtDWnMbLdi5gnzcQhxSwZNuis+1a+03t7MpOdDeUlGtMG+uQM+dA2CAGXvSGn0RkFP129lXlSoR9UaFE9tpC9G5TowzgITrcJcgnYPHbBDC4YI6In/9yjn42YcwX5LkgDKwEmQgdzlfyTHvZfeRtkqsmpj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d43d333855so20620055ab.0
        for <netfs@lists.linux.dev>; Fri, 28 Mar 2025 06:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743169742; x=1743774542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZccP94vSlfyk6BXUvEnclbkKMxBWU/FoFWjWqAr+xSc=;
        b=WmvzkfMUYFOzZsAp5fCFJUqs+spXuR7t1q+4G6sNMip9k3CfKC6V0LFihqXZAMxxwJ
         9Wejt5JVIXsnkcq4sjNE/nT9Q27q/o3G1QDq3WprGGH4KgeICRZ+bFR5VwthGjpw+Xfz
         bfx46ELUF9EZt75k63jprZ4Y2BPWY5jvQZgq5A2yZ8JNvp8LADapMP1KDFLoXnuBaaYi
         12z2U5ZWn7rAyk+5iRcKuOinxnP0XSpUslwM3xToSdzdFGTxS0pwDGQa2Go6vBNM/g1B
         kn2yvhZ0ZFPlY8cPDEl8PZx8c2kPC0kA1QGYeWqD5qQW/O3HTrK1OiLPVJATf5kvxsPC
         TsRg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Sj/Xs4cHqNChjyirmnlLuo5Wp/4PnP7+RWG6uyPWUHOEv7Za7OrwdMlxW9dZ4ibjz1218Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNengT3/z8Fdd44enRuNV66RYgGfS5Lj4f4SEGKP7FgFgtvVLh
	ixtlwf/+H784QMtesTFoPNi3AQnD4TI+cvTsMElDiQMNb01JsGBbOBjNdpAezNpiZzdP6TdT+fb
	sJWHLRSRg0uljxwXwYF9VbmWEsF6GMs/RD9me+CEZroSG6Gl0O7tIvN4=
X-Google-Smtp-Source: AGHT+IGwRYua1iETzdd0MEmIL3HDNfodpZ6kzAALmumare+moQZbATVg3Tb/phYquDGYuvTGiVbb0t0/KM3tnAOm1426Ww8zs2hT
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3d4:28c0:1692 with SMTP id
 e9e14a558f8ab-3d5ccdc1e0bmr85604945ab.5.1743169742505; Fri, 28 Mar 2025
 06:49:02 -0700 (PDT)
Date: Fri, 28 Mar 2025 06:49:02 -0700
In-Reply-To: <20250328132557.GB29527@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6a8ce.050a0220.2f068f.0077.GAE@google.com>
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         acb4f337 Merge tag 'm68knommu-for-v6.15' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bab804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c3bbe7ce8436a7
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146b9bb0580000

