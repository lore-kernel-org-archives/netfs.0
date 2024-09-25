Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433228836;
	Wed, 25 Sep 2024 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222481; cv=none; b=qCHfZWBHNJINPBAovFuXFqtN7l69Y8v4b8F09usQVGyo8dompXeR6MxEQWZh2Ad1+85laEaDkIdajsb1c2E128kGfj2vMygcrVzQRGzMYvCSLeyI8HFSQaNKSsOCSq5VSqElcO29jr8qmj/cJvOrRPYu7SZsHWF87ifEHsy2x18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222481; c=relaxed/simple;
	bh=eg6JUadNkPeoBu23FSpRWKZpfeLOFZgr8IlFAdMKgy8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cf4l5lazs4yXPVHC1QyWl8HopuNvXqadG/+JrQhqVXDEumiZeJQKKT7bTSlP7RjCTfxvmUTPN/PRPjZxyl5iW10KX0wgNXZyvuPscP57rfCVq13jyaHVSm5gnnlQozJZyQU8jsdA5uQ4oBUmablDgMp/Kf3/J8UJw9VShO81SPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcWIBScB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcWIBScB"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so4403483b3a.3;
        Tue, 24 Sep 2024 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727222479; x=1727827279; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+YsbtnugTHXPyFLA8DhHEyqiW3ql0VvB9hLLtok8vQ=;
        b=WcWIBScBc3wdCEA3A6fr0Usq1hEfn3v4miae1NugZGAJy4yuhDr/57wPWZO67s7Dm8
         fXTJ++IzvDDCpKjVmJrWZFQr2RzQk/m6GRx8Ej9jN7Gjh2q2ETU3jK+ncPnqlek2xBUN
         lRkXap68w6bS64/WX7pB6i1OkaMIrXZhD7nCT1NlmO06J+ssltf5hUgSLOcBt0LlY9LV
         RarEkheSeU7yaH6qX6+cqGoOqPpKO7irDqQTuChucZ4H2FayzeDF0ndgHbZ/NckzIPG0
         mgeoDsuEyS0m4fxrxiLSuzDsJugSIqyloCvnLnOTdAlN3mAW5bTOpiXjNGhN9zmz7lsm
         V8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727222479; x=1727827279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+YsbtnugTHXPyFLA8DhHEyqiW3ql0VvB9hLLtok8vQ=;
        b=QQmL1PRfT74DknVKtNNvwBNQmYdCcj7RAbDbe74dNnBDTNA5RgfhOY+yUr9n3IC40n
         j+8sQnqIDGVTb8P4wUmDhdili512sLykx6INcYLXQW+95VT0cilg5Bb4kimwiLrig0+T
         pCv0Sv6An1gwAXctTDYcEKAYcmzrpa675Bli1fTUVlfRpLs9CtlVTAnvMnpA2KhAIykQ
         P5uI8JvXSSXjNjoeNLod+eO912GHbY4T77mttPvLBEPd9fVs7p9tmcLk7MwBejDKn79E
         Tk0mVus9cpx45o7tNRaKOlUYHnx3KCYh4W+M/TmL6pA5yVX2W9Vdt2QY2zVDH1mMn0Jg
         tG9w==
X-Forwarded-Encrypted: i=1; AJvYcCUEifggE3oOAlMAMHx/Z11zbjiViHWfihp8on4mNN7wg++1iPWlLCCO8PQNYMRdsTvAeIVZ5Q==@lists.linux.dev, AJvYcCViGpbZMqktx3dIx+c+uETEiJVwOan7S+ftpBDEpXgn7uozHfapzyldWJDv7ryEZZXyRjMvMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywoy9bExXMYFpH3PD4Isj9ApZtY98FxmtWLYzLzDFz3+XHpu+67
	9/6CPMZlNzEmypTk6o/V2uP/ut5sz3MGF7MCMvWSvYGTNJ6Ebbyv
X-Google-Smtp-Source: AGHT+IFvocGse94WXxiZf5ejfW8ZMZrfybKRDozJJhDfTj+R6qo5a3bNsb79W/etWWrqI4tOhHvi1A==
X-Received: by 2002:a05:6a21:e8e:b0:1d2:bc8f:5e73 with SMTP id adf61e73a8af0-1d4d4bc0cc2mr1117741637.38.1727222478887;
        Tue, 24 Sep 2024 17:01:18 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9cbc02sm1675483b3a.213.2024.09.24.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 17:01:18 -0700 (PDT)
Message-ID: <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
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
Date: Tue, 24 Sep 2024 17:01:13 -0700
In-Reply-To: <1279816.1727220013@warthog.procyon.org.uk>
References: <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2024-09-25 at 00:20 +0100, David Howells wrote:
> Could you try the attached?  It may help, though this fixes a bug in the
> write-side, not the read-side.
>

Hi David,

I tried this patch on top of bpf-next but behaviour seems unchanged,
dmesg is at [1].

[1] https://gist.github.com/eddyz87/ce45f90453980af6a5fadeb652e109f3

Thanks,
Eduard

[...]

