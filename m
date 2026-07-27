Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C33EF64F
	for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155224; cv=none; b=plRVaKU4JllhPhFKjCU0wvt7TPeK3SUuPIy0J02I3LTjpk8zFwmnIObMqDzNRM2XtVoSXdkpwy5VtZUEBvcRoQ3tvRm28F5LsmHQhxO3QD55xg+LWcD2wqXbyMUpM0wq54rhaDBz7AVcjmCTQcxqx861kZVvL2eTMCNAdpiDM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155224; c=relaxed/simple;
	bh=gUO/CcWK1D6oNtnuS3Yk4w244iY6313rnpPLKhs/t7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F6k9tN+txjrzXb0udkxzTpYQVOIyYt2g+y4QjXlpKuP+/okx4lPrsn4iKKHaJ6lyzrnkowXNp6Cx0iwrPwP5kCBtzzuF1LccjK/D15LXV5Ml0H0VJas8meulceoKsD4i9G2SbM2kEye0ubqD96zxX3NpgDMlZID0I0MKM2Zt6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-485ebc5706cso5019083b6e.0
        for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155222; x=1785760022;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WaRX9BmsXwT/x48OgKFTtHEAv0wRi9sRmyTf3sNcLew=;
        b=VkAYvOrdr+2gyryezebnVvnb+aUTv3mhN0HbiF8i+ZO88b/5yMMWbc/L1h6SJHI1mw
         CBRI9ZfHrBzlgFv3D6FwENlbSUGKtV+DUR1wtWYkaYYEjs2xdMNV7xArSDR4l6jDiHUI
         QC/9yMnkxvLilZfTqiS2vUapJr3yLkFl/Zyd7awc0B/1gq0pCawZG0wQil7SKR/thlkN
         hFi2uyNfe/rNnqgbuNdn/+OETsehHkDIWFY3nM0yHW9zZmHPf6BVQmKFoq3as+ZGIX9H
         7HSuL/gcvB8vZsTxpc887f/mB1Hdf6AZnppUVyKLOIcnuBAfc5+v6mpPV9mu6AThSe5s
         L9cA==
X-Forwarded-Encrypted: i=1; AHgh+Rqikms7++66Vs8Lm6DpAHsyyzPlsQ07/TYbySOKlTeqmTjVKoNZbF+0B3GdwM7tPEuDrU+xIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1XCdLHMWxIJTc64eARpnL3tCjbB5MBGd3F6CVuEEuoAQI7pmu
	xsU6T80d9/g0MqGYuGb+yMOgQeji4zcdNKeb0h5efE99Ha94iH7+88N23XXitY424urbTgadoNb
	akDxLmXNwZcC8QwU/KSnti6Nsss6TclzGSz8Z6eubg2XZQ2aT1ipIst8n9wc=
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fe2:b0:4a4:c13:707b with SMTP id
 5614622812f47-4ab5e50e439mr10467776b6e.17.1785155222099; Mon, 27 Jul 2026
 05:27:02 -0700 (PDT)
Date: Mon, 27 Jul 2026 05:27:02 -0700
In-Reply-To: <1097630.1785154821@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a674e96.70955b6c.323240.0042.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
From: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: patch failed: fs/netfs/read_pgpriv2.c:53
error: fs/netfs/read_pgpriv2.c: patch does not apply
error: patch failed: fs/netfs/write_issue.c:749
error: fs/netfs/write_issue.c: patch does not apply



Tested on:

commit:         f5098b6b Linux 7.2-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141558c6580000

