Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43C1BD9E9
	for <netfs@lists.linux.dev>; Fri,  3 Jan 2025 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946437; cv=none; b=GGmDC3aCBTimtm0Ixz4AuaGvcv0ZZMlUUVsfsmuCNatYvK60CPkEEh/SVHRFhOyyj5ORzW7ppncmeUpoI6i3diFWFPWgWiLm+6xrWR3/9KGNKhjyUj0UfcHxFAzMT0wiJRIjyyKH/LsUXeZh7w6bi+R3IH2s0MVPHWt2JmsAAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946437; c=relaxed/simple;
	bh=3W4IvzMIr0xQBWC38MKeqTujA6CjHjjvg/i9qTVqI7E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=A4K2qgFMXoKqdCFSFxcN4lLRoZexsfK1hpEkb4y/PfY+UIx4uW+xSQDxZexzdBO5V4WC+jDgdRk6gosNv7Kezdce1b9BEjfUNSitAzH56xWKJj0gdUpkQtXuFwJOZk0dqgvmIiOmNr8gaDjbggegA3TrzZxOOevryS9BVggMrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844dfe8dad5so2186987339f.1
        for <netfs@lists.linux.dev>; Fri, 03 Jan 2025 15:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735946435; x=1736551235;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W4IvzMIr0xQBWC38MKeqTujA6CjHjjvg/i9qTVqI7E=;
        b=nqyp4eejl4fyWXxAlGAmnWcxZkHoQ8yj0/ytLbZoTrL6VFJibVBOyw+wrCF20XW1DH
         Vd8nIIAoVzSXdDoaYf5HYlK8C6eaDGjfMliUANqVxZ3xcP1wccoHSnqonm1hhJveCn8z
         h5s6vGZ3AhusuCNi7jb7UNWZqdJNv7DOGoLcKHGY1v48vKDGK4TbygKe5eOkSZ0tt3lA
         ddoBscPbLQxOpJFlU+Dm9kj1A7gngoDPU5bJzWDCw3/T/FrWTu580PbP+QbAoyB8FCcg
         m/f6t9OuuUycKU/IbBVUXCz507azEebVfkwK64k1v/xfTpncde7wEYeCmQ7JxaiVpN55
         lY1w==
X-Forwarded-Encrypted: i=1; AJvYcCU/JBmVCzcnhzaaHVECW0qezaq5aKmcZ0bK3nGPVoZH/xSAFINoNkIIHTI7yEAmEBYPUr01Dw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqh8eC9gS7emtkIuRfmqzc7iARDEYBmJM3q9IRGkqOZLTvGcNr
	zgQfZeqLtY7pjFYohvfPu8pY/EhJ88MEzDzABJ0Cmw0UQtkKkFWOa7Ndh/CNaZghUrSDXF2nuZz
	afxnJn8SvoU0tUngm0kDLHaFLJkO40qbbYO1ekzcZik0Z1pT1SHu0oWI=
X-Google-Smtp-Source: AGHT+IEvWnW6oRM+vgCHfNwa24VSQVfBs3jfJK1qg6plgc5PIBRpIhZkcYU/J/vcoboVr9JogOoa1tw5Leo0QrhbzdZ7P2dDUsS+
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2481:b0:3a7:2204:c83e with SMTP id
 e9e14a558f8ab-3c2d2782867mr531960805ab.10.1735946435406; Fri, 03 Jan 2025
 15:20:35 -0800 (PST)
Date: Fri, 03 Jan 2025 15:20:35 -0800
In-Reply-To: <CAJnrk1bRY+KHdJ+yjOrb4ATHF2Xec=tUmPrn+nEPjRzNbUY7mQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677870c3.050a0220.2a3c1.001d.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Fri, Jan 3, 2025 at 3:11=E2=80=AFPM syzbot <
> syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>>
>> > On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
>> > <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>> >>
>> >> > #syz test git://
> git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
>> >>
>> >> want either no args or 2 args (repo, branch), got 1
>> >>
>> >> > 7a4f5418
>> >
>> > Sorry for the late reply on this Miklos, didn't realize this was
>> > related to my "convert direct io to use folios" change.
>> >
>> > I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
>> > fuse_get_user_pages on allocation failure") should have fixed this?
>> >
>> > #syz test git://
> git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
>>
>> want either no args or 2 args (repo, branch), got 1
>>
>> > for-next
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> for-next
