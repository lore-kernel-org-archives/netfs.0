Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C333101DE
	for <netfs@lists.linux.dev>; Fri, 19 Sep 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284599; cv=none; b=h52Nj7dJD6kiyCu7bNZaG36c9rrmCX/ayeZezNlYS7qDS1B1Aq3gN599kIjPp+6adeJE0MrFokzDstG6C4FgEdhPIQ6CTdlS+pRfAekmtHMDg2JWwjDe2TO9dB9q3Sl1SDtM2z5PXTDGfxIzAcKojFvms9B6GGpT0PVbAnsBtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284599; c=relaxed/simple;
	bh=KIJ8hSpUPj5yJOYsOOvoMAboQbBE3gvNf+eNVgk4gUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozkbLl0Z740qAQpglacLEPdx3KBl+zkzbYF1CsZxLFe7FQGzNSXLLuOeAAs0CNcjCp+Y1R80KiCtUBvVy4ms2Oc03BhSbN4maAGWeAgQOmKmIr4+P9eFteiE8VZHhXRpRMr3lwqY2ZiLJCHgzpb4tbJpLsWCRtLYN+2hyqfdgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=qQi4P/Js; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="qQi4P/Js"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758284591;
	bh=MwuO3s4MxolpqYas14pKeShCxVq/OriEAKTj9BTUoq0=;
	h=From:Subject:Date:Message-ID;
	b=qQi4P/Js91JGq1SYRXjn/7bTflYhpI91UtzTtDPBHIDEK8Ws/+WjncpSV/d9XFw1C
	 /JkZLcGly1+BJtyrLt1mMbcPjHDo6KVZ59C1VM4qAlMNvog8TuAs0Vv6pqag3z95bw
	 j5P8wQWrCLLDiKhdQgTDJO1K2PPiX8mmWK9pU0Bs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68CD4B24000036A3; Fri, 19 Sep 2025 20:23:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6774046291924
X-SMAIL-UIID: 1808608B694D4BA88487F3520188493C-20250919-202302-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	pc@manguebit.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
Date: Fri, 19 Sep 2025 20:22:52 +0800
Message-ID: <20250919122253.7178-1-hdanton@sina.com>
In-Reply-To: <20250919064800.GA20476@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 08:48:00 +0200 Oleg Nesterov wrote:
> Dominique,
> 
> according to
> 
> 	https://lore.kernel.org/all/20250919021852.7157-1-hdanton@sina.com/
> 	https://lore.kernel.org/all/68ccc372.050a0220.28a605.0016.GAE@google.com/
> 
> this is yet another issue seems to be fixed by
> 
> 	[PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
> 	https://lore.kernel.org/all/20250819161013.GB11345@redhat.com/
> 
> are you going to apply it?
> 
> Hillf, thanks a lot!
> 
Happy to test your fix.

Hillf Danton

> Oleg.
