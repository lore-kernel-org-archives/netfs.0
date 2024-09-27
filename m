Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560A188CC1;
	Fri, 27 Sep 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470514; cv=none; b=PMlMCeP9NAbYBv9SOkBXLCAdRj33w5GXMylHbB1IvqznDTn79DsrBVmFSIZ+o9tjpHo+e6YOMLZCR3hOU272e87On0jtjwW/Kp6jkZSK/KQEWoLAdEyiWNMG77N24ZCeAZmYmkZOYBkGxh8LgRvV/Kd77XFQ5hMrZBWGItRyo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470514; c=relaxed/simple;
	bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5dm6PZM8z8CISI9bX9KHp5vNd0DyEPFoFOs/z+t0U5s5mkoeQwPnl74Ao5142KBDyXAxpNBdr+t8z4LCzVTCcinqXNqkuPQHjjNMDvDdSGTY/IYUrLwoeok+M84+Qr4BUoDgHB/jYo6v5x7CyaDwm9VYg+5SAC9iJB+PgoxGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkDZXua/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkDZXua/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e285544fso2067351b3a.1;
        Fri, 27 Sep 2024 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727470512; x=1728075312; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
        b=IkDZXua/PWM/kpm100hdMNc39D7oJgeSuvrMYZkWqfBKVtujzhvnyQeJT+P8UrOFMI
         thS6tlvJTD8ljmo+ujmf0y8OyYPDHSTbAvpx7/fuAylzCE1OCKjxqKXv9JfLXwsq3lms
         ZwV/AQr79NSDAEtqxU4kAFkO1tWonRXoCT6jOlYAPeBMnAWWObD36Mdvekk07t8ulEot
         MV1sqndzG/JvdsbqozAelNyMmDbbnmvWE8pWM8bBXKASaeRWw90AtHOtcE68GBUK36IA
         uR+hnOkuFxtEl8U1qVjk7NvC79Y/VqTCTiVqHTmQaRXKOFxkV4bY2kzYloflm3Dois+u
         r1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470512; x=1728075312;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
        b=qcRqMQEpSlcvzBjotP2zY8NS2tq5zooCkh+xHqNXdt1dS5Vwsu4tecGcN0UeLnEZGH
         3kmQlCr/MsD9pQJHIACa3EGP0lIL5ovWzKKDgcZXR5cC2zqOT+oJPQ7BuBbXHrnLl9IK
         cUsMU0AyIiyTliNwlS0JhqRLLVNXaXvAc0Whw0hD5PqfOYFnkY6d4wzr4WQ+3lDUs0p0
         z4awgpqMMR4JoOyNboBHhOXocDjZf7bTkcoyxUtNpfT54IEi27zv2cU8u6SfTxmnZSEQ
         t9sUoEKtWujLB9TPktj6klsk/joHBPQE20W9JJvR3Q2WhlxzSdNpKbrIMJowtBg6w8aQ
         KUTA==
X-Forwarded-Encrypted: i=1; AJvYcCVx5hw3hJ4ZJ0gW9MuDJk/4eg++20Mx848yLDNxy23TcP72LiOnYsCedLyMScn9aP5aQJiaGQ==@lists.linux.dev, AJvYcCXUdTGdAwp/LnWkHiRT3N8zujsyQUDIogK68eW106Sg3Izk0jp/Sksfkv39gjr/s5O0gcxH1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywoak1cYtEMDXpRC+IwRumLPUskQAidMR4uQgfQEt11x/DPPu1F
	M9Hm1Ec3V0CiGNWuuqPM3qhIUYBm1x26NTRD/JEvWAB9GOhP9zP2
X-Google-Smtp-Source: AGHT+IG97WQ0sKf6nP3kVcYM7xIWbrZHObvDCRA4X7I+pJRt7WQ0LRz1ytlfbrB+m9K1oZ0O2AT5Aw==
X-Received: by 2002:a05:6a21:1690:b0:1cf:4422:d18b with SMTP id adf61e73a8af0-1d4fa694d0bmr5811129637.14.1727470512137;
        Fri, 27 Sep 2024 13:55:12 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536b46sm2025461b3a.193.2024.09.27.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:55:11 -0700 (PDT)
Message-ID: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Manu Bretelle <chantr4@gmail.com>
Cc: asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Fri, 27 Sep 2024 13:55:06 -0700
In-Reply-To: <2663729.1727470216@warthog.procyon.org.uk>
References: <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <2663729.1727470216@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2024-09-27 at 21:50 +0100, David Howells wrote:
> Is it possible for you to turn on some tracepoints and access the traces?
> Granted, you probably need to do the enablement during boot.

Yes, sure, tell me what you need.
Alternatively I can pack this thing in a dockerfile, so that you would
be able to reproduce locally (but that would have to wait till my evening).

