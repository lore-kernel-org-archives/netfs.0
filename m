Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA3192B8C
	for <netfs@lists.linux.dev>; Thu,  2 Jan 2025 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849179; cv=none; b=DDvznh8cmrrbecA4MVe1K6ulcBCW4zXAzxcHW5Kq8VgDPj0Tl6if6vi4986PY6ibeWinhMZksowhKgrcKrGcekFtWDbPD0Ebaag312WN5HvkNlsTx2bDXorsTlLXFXpLqgoVb2SRcZ+KnASFNFGb5Ag8SDY+3KBfQn66fYpLOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849179; c=relaxed/simple;
	bh=z2O2sjeBkq5rD9KqkyvD3hkUgTKjHfpT4Z0786PjW9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/6E8QGsnWVbE0FqtdjLKmpap7FZgh6KB0O0zuf3/yfHPoNg6Up87Ip6+GvbtLj5kFNPDGQbgpUCWlF/RBpQmvsZVJC1pMgGqUqZdzwZEC58eF4MUIyBn/7uesid6am5qZwYqhcv9OPhGUmrvBIrCJiYZPY0Qe++Yu4dlc3YqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=I5AJIX7v; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="I5AJIX7v"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a8d2d7f1so95189891cf.1
        for <netfs@lists.linux.dev>; Thu, 02 Jan 2025 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1735849176; x=1736453976; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2O2sjeBkq5rD9KqkyvD3hkUgTKjHfpT4Z0786PjW9E=;
        b=I5AJIX7vSNwKHEjDBdVfh4myYw2BTxczbiqi18XhOeJiPbPT1dtxx6AY5WpQf92o66
         UDgeGQipwvKd+OGLZRZhiX5F8PmoBtUVM5FCh91C9mMtKqOqwKj6t4J1kbC3Wgc/APYJ
         WegYo06+FUqrSgZq/PLdNdFjC0pCy16l6OJ2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849176; x=1736453976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2O2sjeBkq5rD9KqkyvD3hkUgTKjHfpT4Z0786PjW9E=;
        b=ez487joEFoOGIu4qmb1ITcAVNe/mqOjwzwt502c37y3x1pPtwqdEb83vFdJAr8vwTY
         ydDtapYPlcfP3FuPEcFfhMok568/vQ8anqB3oPDD9YheHOq1wJ09WQOTUieG+xlZKqt0
         T6x3Vg9Rnb7wSg3yP1sd+c6bT1A+GttDVReX+qM/yyhW5Rn69ixoLNcTMup9oWqEVLd9
         F+q9L3NaJyuqIbalgGAlA8GQXzB3yYkpTyxQmxnTTwpsKvsOzPoNHRa+3YfDd4EA2YvZ
         K0uiXbPnS3OiPKS0n86oYszu+fuqhzfDD49FEOu+7gEYrxyxaW5xPg+l78gV04A6TONu
         uYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9l/t5awc6LVZ1y6n1/IHu+y5N9SQM1rLwMnwXLQvsb4na8qgfoqaYp6GBWRJQqBQF5dxFMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YymKscYDiwMtftVjiLI5OxHSnYxoUQpxkbnOjE+NsRAIV8ojFpk
	mk2URYbSyD5rla3S2Q6A/L2Hilzk9UASORe8D8r1jJvBtirTamYu/XTu0jT+C6jb21FWUZoZMRs
	cjunx7UAqCys+IfpDmIfcXWkEXK5c2OLH22Ga7w==
X-Gm-Gg: ASbGncv+F4QysHPHlvawBGkWDUmQMGniqu5if8BfiKg7794uxGc9ZPU/RZwkXVPlsOG
	6Q488KOyIFG/SvGlA/ZOtAgFpulAEPdcxn1hEWQ==
X-Google-Smtp-Source: AGHT+IEgLuKQSVpPB4YVR+D/Eu0WUZu+a404D8ur7VThLUXKgoTrU0YM7R7qxZYE0eU0GM6xCI9vUylL3MuySJTw0wE=
X-Received: by 2002:a05:622a:2cc:b0:466:9938:91f6 with SMTP id
 d75a77b69052e-46a4a99e904mr799738851cf.51.1735849176470; Thu, 02 Jan 2025
 12:19:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJfpeguK9Baf4hxBhqS_313bo9Z0ZAGMAAbkaOMQRKTK_auk=w@mail.gmail.com>
 <6776f489.050a0220.3a8527.004f.GAE@google.com>
In-Reply-To: <6776f489.050a0220.3a8527.004f.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 2 Jan 2025 21:19:25 +0100
Message-ID: <CAJfpeguPw9CsK56RHGTfpYhfh4V5Kj8+JHJJo=hJDy39=RB+3w@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
7a4f5418
