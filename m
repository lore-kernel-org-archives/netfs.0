Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCF1DFD9
	for <netfs@lists.linux.dev>; Thu, 22 Feb 2024 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629366; cv=none; b=cO64hhGFHv175U7g3VQdDIN3HxFtmgpXU8JT3sj5i09QE3Y/BzEMk/wKVU+IYFcI6rE6pZd2JNwO8ERgtG0Cy5MDMG53ZWG8PDzqjEM5Nu0wrOMRsU0MUDEwHZHEMmnpyLU7kBDzlGB5rJuGYt+bIDQdCnYUSZd1s8XTWRDOCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629366; c=relaxed/simple;
	bh=5Brm7cYLz1WncvBj6DTMuWNmXDrJrz/GLli2N2sCO2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fI2577eeZ/v8R+gtZulR8iSHQRjVIOSJsBScsLP+AsVh1yMZuFvJIjW/ZuIl+5Q5LGDtz/NafGSvlsug9rHIqrLrrM+Obc8ZUmbq46r/8A/XLr5NUXu/WEOCa2WU1T/QQls0P/Dum1cDnOHaCtRs9oC6+asVBIYp+X8pHV4h9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIpB8Xgp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIpB8Xgp"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6081639fecfso1164767b3.1
        for <netfs@lists.linux.dev>; Thu, 22 Feb 2024 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708629363; x=1709234163; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMUm3t0lorhkF3irlFp+ZHb+WnWzsj32jWcajitTJIk=;
        b=UIpB8Xgpi/qGQ8zpbSBjcPeHgXCKiS1SfogxVLqC3KyTZZSkdk5t+NT6kQGX9kZm60
         lwp7uJphcpscGsbFL+xR+XotdFBxCgFtjbqtjukp8YIuD3f4W7SjMbKVM/KS5ENAX1lj
         uZpi4H/Bf7FDma/B9+vQRQ+HnmnsfNny7TDsF0IEthHVA719FJMDoSuUNmMPBruerk+6
         llnwSO++ljN5MAMdX0hIhnRrajzy7ZK4VpXHHBvyaWzZSgyn4jdoYzQS26wLtYjFMwzH
         Gy0iM6PCDe+awcjY9mqAW08mVKU6oXKAt+atttKWFv7rb3hOxqWl6uZvRGII8bSeSwgn
         4zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629363; x=1709234163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMUm3t0lorhkF3irlFp+ZHb+WnWzsj32jWcajitTJIk=;
        b=FgZKYIqV/yHssYUCuAghNpRppBeAZQTkK1lzDakhzq9QcK/+8xCMiqzh5TXwN389G9
         5cFcKUgTY1vsb8KiI5tdM6tL7fp7Rf6EcrTdhlaPnnRpU1gx3Qz3z7tAmLnuOEb8m5ny
         a+dM98I7iiD/aDWeUL4/i2D7AVwo+SMJqjk+0GvMcfbB09Ec5E/l+CuxpJ+9hf7iwjIl
         cCH28iP0F5iE2p89HOHo6EmTAHVvil70JClNnN2dKK21AheUMxDuyyTCWOfSkjzgM4ET
         Cf85Bx0x+Kk706b+VO7CFkmQNfucGtNGSeiwEfSVsjHvl2UPU/NaneeCJ3BpW0DmDneS
         drjA==
X-Forwarded-Encrypted: i=1; AJvYcCW9yt93yDCg4MfH9ODsmHjp3pF3WyaxXisZFA1BjbbJV4cJ8TeHpHD28IH+gZoNYkdM9r+MKJCftU5uRgY8F0H9pVSn060=
X-Gm-Message-State: AOJu0YzMRH6QKx+QRK8rgCAev9r5GfgOJonWcMKulzmLctKCxL51zmsR
	fZ8e2fC7GWZZ20Yg5n3/FbYwcXDpp90UWO9TPJL3KYmZbfS2xAf6R+R2p5e1g8/zLA2IH4XtonQ
	5B2sg/prkWM0yVdnAsQ==
X-Google-Smtp-Source: AGHT+IErsJKDN7B0tFhqzkw22OBlmNI2VCFCW5jr+ldBfGgfOTaIcEOTFZlyakeEI7zsf/NVho1iuq1vdkwNZv3S
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:10c3:b0:dcc:8927:7496 with
 SMTP id w3-20020a05690210c300b00dcc89277496mr795ybu.5.1708629363699; Thu, 22
 Feb 2024 11:16:03 -0800 (PST)
Date: Thu, 22 Feb 2024 19:16:01 +0000
In-Reply-To: <ZdeaQMDjsSmIRXHB@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <2701740.1706864989@warthog.procyon.org.uk> <Zbz8VAKcO56rBh6b@casper.infradead.org>
 <ZdeaQMDjsSmIRXHB@bombadil.infradead.org>
Message-ID: <ZdedcU9NRJ8-ws33@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
From: Yosry Ahmed <yosryahmed@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hugh Dickins <hughd@google.com>, David Howells <dhowells@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	lsf-pc@lists.linux-foundation.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 22, 2024 at 11:02:24AM -0800, Luis Chamberlain wrote:
> On Fri, Feb 02, 2024 at 02:29:40PM +0000, Matthew Wilcox wrote:
> > So my modest proposal is that we completely rearchitect how we handle
> > swap.  Instead of putting swp entries in the page tables (and in shmem's
> > case in the page cache), we turn swap into an (object, offset) lookup
> > (just like a filesystem).  That means that each anon_vma becomes its
> > own swap object and each shmem inode becomes its own swap object.
> > The swap system can then borrow techniques from whichever filesystem
> > it likes to do (object, offset, length) -> n x (device, block) mappings.
> 
> What happened to Yosry or Chris's last year's pony [0]? In order to try

For me, I unfortunately got occuppied with other projects and don't have
the bandwidth to work on it for now :/

I don't want to put anyone on the spot, but I think Nhat may have been
thinking about pursuing a version of this at some point.

> to take a stab at this we started with adding large folios to tmpfs,
> which Daniel Gomez has taken on, as its a simple filesystem and with
> large folios can enable us to easily test large folio swap support too.
> Daniel first tried fixing lseek issue with huge pages [1] and on top of
> that he has patches (a new RFC not posted yet) which do add large folios
> support to tmpfs. Hugh has noted the lskeek changes are incorrect and
> suggested instead a fix for the failed tests in fstests. If we get
> agreement on Hugh's approach then we have a step forward with tmpfs and
> later we hope this will make it easier to test swap changes.
> 
> Its probably then a good time to ask, do we have a list of tests for
> swap to ensure we don't break things if we add large folio support?
> We can at least start with a good baseline of tests for that.
> 
> [0] https://lwn.net/Articles/932077/
> [1] https://lkml.kernel.org/r/20240209142901.126894-1-da.gomez@samsung.com
> 
>   Luis
