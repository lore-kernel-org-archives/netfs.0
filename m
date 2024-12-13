Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8A1E3769
	for <netfs@lists.linux.dev>; Fri, 13 Dec 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106424; cv=none; b=awKHH+pj2PtTIuKH7yQSYXinWWgx8K0dpGSmqsf2bnlTj8b4KDSrhcO8oas1E5vQSgud/V29DRPmsF68KAJp2IQXwfxWQweGbauaJGNLwTXLkIWQmvSPFN77JUQjwGk7VKl2JtEpyqr44AQEWMdVgyZ+0ecriWlfRyW9VydTc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106424; c=relaxed/simple;
	bh=JeYzecM4Ws6DAx8d1eYSSaAR9Hxv7aMjtxrtoNso9js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmNF9A3qY+Wv8WFZXrdXn4DtSTpd+EFFdbiW511cKJdXinlgXGGS6unOrgK1sAm3yvjV4n0sYmUzHMr8LuuLBk7LkiHw/gdfEr1lY9l4GLXJbiGuP0akyQwzovtW3vv/PehsGuy2n6liopzRbZgCLziWhlv+LYvnJXPLr2wt5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TuXroBuK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TuXroBuK"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6ff72ba5aso47528585a.1
        for <netfs@lists.linux.dev>; Fri, 13 Dec 2024 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734106422; x=1734711222; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTgK8vtVJlVpnYOvWfFrTdJyV8eieOKxBt4m4Ra+gVk=;
        b=TuXroBuKZSmCDFKFnyAXAT0uZpC70NPFRzS7RT6rEnkmi8D2DCbNyOYYQ32AHC4ZYp
         Rta8IMkFrFmKmxfAzFS6n24aQ3tq3LObpA12nsTXmrnccnywOEfYhHmD+RffUPnf6Mma
         LJNU0ua9xpZVyoYbwovAZ3HOmyxEy8tnp677I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734106422; x=1734711222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTgK8vtVJlVpnYOvWfFrTdJyV8eieOKxBt4m4Ra+gVk=;
        b=cG5mL8LN8m865BIf0nShECDWOnpRPX96prXF2MRt8XyW2YcG9DpfxQsNOpLjmEZ70z
         qiVyroiPmYAOtdipl7FkNLSV8cnA3+QiVS+AmDezlyQUeS3qytRVLiRFwh5KarfBvsrT
         qtLe40T3QtHPv68blLjvSpMhN3qhwVQ8xKOapZ8rfVyw6U7KFmExph8mpkWG7H1IKAAq
         NFudS3/CYG88q1q+fsyroYXE908BIH3IzszY2u3uhEGeo/6xLGlXhF1gfe34uK0j1Def
         +wu44ArINImitxZiXxT+iBWK6xhCzcrWWiF3j64msNeUsJh0T+2LQSKSaYJnKYMBJC4s
         tVCg==
X-Forwarded-Encrypted: i=1; AJvYcCVTUw/UrRKANutdIVe7nC0n+0vLsVDqcK9+3Hom2Qu5iSm281Rro5WJJMbrcuqQxpxGMhLz7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcxcq4fgVz0aDv53htsVeRorFRQ/bjIAhD8N3J6WTBIpZIENIU
	fvwjFmpXVgDLzmNSL3EDrs0RI8SLf+MWcQjHAdccApIIga2xxOyGivYleHTIV6XlUru4tfGbTAW
	atbegFbvZiX6x2xlVWfhQVwo783tQJa7uVkJ8gg==
X-Gm-Gg: ASbGncvSpYEBjzvj45oJ8CgU6oFNOHKp4nOJ/BAot6b4nIJwvLiD30f9kMgRWqkf/iI
	0oUVesMCAZFXI1TCD2NNHDxdmFKYXPtdXYhUsFg==
X-Google-Smtp-Source: AGHT+IEK7cPvoYZztp8WXRex5AggE+7kQWRBIjyrSu0/57plBJrXdZPJ6JJi38gMdr7TZFixPLtwoFF69xUnqROniPs=
X-Received: by 2002:a05:622a:58d:b0:466:a584:69f8 with SMTP id
 d75a77b69052e-467a582f1famr58994161cf.43.1734106421923; Fri, 13 Dec 2024
 08:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241202093943.227786-1-dmantipov@yandex.ru> <1100513.1733306199@warthog.procyon.org.uk>
 <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com> <4b9f34f5-7cfc-40e2-b2a7-ad69d1d81437@fastmail.fm>
In-Reply-To: <4b9f34f5-7cfc-40e2-b2a7-ad69d1d81437@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 Dec 2024 17:13:31 +0100
Message-ID: <CAJfpegtvJr7zKShpFGtFUT66+2gz8H6Js9srhpaqUhXA6061BQ@mail.gmail.com>
Subject: Re: syzbot program that crashes netfslib can also crash fuse
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: David Howells <dhowells@redhat.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 13:41, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> I had already posted a patch on Monday.
>
> https://lore.kernel.org/r/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com

Sorry, missed that.  Applied your version with the above test-by's added.

> @David, is that the same sysbot report or another one?

It's a different one, assigned to netfs, not fuse.

Thanks,
Miklos
