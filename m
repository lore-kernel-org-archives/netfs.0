Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124825D1F1
	for <netfs@lists.linux.dev>; Wed, 25 Jun 2025 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852279; cv=none; b=hEvMFY2r3C8UugYajYu/d9+4MRtb7Mw5yPYlZVSb6F9kQ3njC6v8W0woFC9cuh6qqu223lOtGESu5ndTW428kY+5hhOxu0QYj+bBuSKCRcb9vSg+unS7TuM8EJdf/e5mWy8CrHvNOJbnYbaXTlkVaLemN+9Aot0kNW/1wj9lH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852279; c=relaxed/simple;
	bh=y3NNDejVQJ1CgTfZFcADg6wM2IwtjjH7Xcu8RJxVMEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqM2G2cT0FmBXAHDwhIab4flKAviZv+DqRCBIrxXpzeJ6Z19FEJxiOPUA5G/WGdGfEiok8gF4hA6rZA9ut+Arc9UxD89xUaHI6zWRYHBoY+aDcukMCCYNIRSqAigWk6bzTMzcNCp9kXsYxNgRK8VGtvn+rSeP9DEIed9DguDqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=icpCHs1G; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="icpCHs1G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=xMUsiXvQEf69tnf2W3tpfU1jFomrgiuQ867Hr3ffK1U=; b=icpCHs1GSsI+E16fhWdGBiRuZE
	vUNAQ/2j1/VWj9z6DAMTuExUZQp63lQOeb5M6mug8a79RMkook19AryUmXRSmstUvZkUJ4jm45T/1
	Uv2KeMTWLhWtqJVal1VgocV9I9Du8zGWYAgpYQekOmMsQFP6Pt+1nUuRV3xN22QWrvsOZJzvBgCww
	JX9hTHLlmdF9MD2FrA8rECOi4rM7mwA/0xUPF8mZtJ7v7KSIM/F3oCq26qOvCmD4pzdlRR5qpquLH
	0Ji90VrFatLIbBJyT8EKdJYPlOgccSk151zG2f1tTgl6Xg6bAA4Kt+BDdt8+ibAv9hMAnV1AnPTtW
	SSVyuRdoDqCksT6bi4Pq6Rjhf493WWV5HheJk4fRMnN4QixUFvJrEAyQSit+WeLpsQv3MS5sw87EE
	19bxuq9L8IA80u4XNypFkrYfpsyOqME7ROk4on1s/oPBUT8YdbnaKXmPpLPSLOaSKMxBok2LfxEh8
	LxB4GECDjOUipqB6vgIr8pQ7;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uUOep-00CPIo-0c;
	Wed, 25 Jun 2025 11:51:15 +0000
Message-ID: <e867b6c0-c468-4fc8-a30f-215b5dd18bdb@samba.org>
Date: Wed, 25 Jun 2025 13:51:14 +0200
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Collapse smbd_recv_*() into smbd_recv() and just
 use copy_to_iter()
To: David Howells <dhowells@redhat.com>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Steve French <stfrench@microsoft.com>
References: <6b69eef7-781d-42d3-9ce0-973ff9152dd5@samba.org>
 <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org>
 <1107690.1750683895@warthog.procyon.org.uk>
 <1156127.1750774971@warthog.procyon.org.uk>
 <acb7f612-df26-4e2a-a35d-7cd040f513e1@samba.org>
 <1341840.1750850709@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <1341840.1750850709@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.06.25 um 13:25 schrieb David Howells:
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>>> [  922.218230] [   T6642] kernel BUG at mm/usercopy.c:102!
> 
> Ah, I don't have that config option enabled.  With it, I can reproduce that.

Ah, allocate_caches_and_workqueue() needs to use kmem_cache_create_usercopy/KMEM_CACHE_USERCOPY...

I was already using that in my old wip smbdirect code.

metze

