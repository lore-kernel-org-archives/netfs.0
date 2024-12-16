Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3C202C38;
	Mon, 16 Dec 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343900; cv=none; b=nMJUV3a69UuDslIVB0gDP1kjVGfQysBSiGN3YV9i/6s5g94tX4Uj4+xenVp12S+8I/Qxns0mUSR+bag8XyB9b4w94YJ7PfCUc3f1dOEOEq7R0Aog2d1IXsijKHiRPH8KL13UlKs8WZ6Fx2Pdvsg/+8N2nEXMU4hd3tKPyIq07/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343900; c=relaxed/simple;
	bh=rerkDv4+3ixVJGqlsrEPNvGYbtkP0sOJsqUbWCAaK68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nq2pQac55EAsTRe8/ZuSElpqzLIQVvE5kcpsqINJj772vFihqSE02DbA4UqBmjWp1oMALUhkp+IhE4bCU0aYXFOBYy9Jaepn0nZv0d1yEcmqS3S0MqFkvQ7hAdEqx7eirwdQhK7u4VGwlSbVIi7Yp2vQ1ouzli8F8WK4NYpP6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meR8UF+e; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meR8UF+e"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728d1a2f180so2820147b3a.1;
        Mon, 16 Dec 2024 02:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734343898; x=1734948698; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+ixtMUrgX7I9rD5qvImPgp6IqifPuxLwfcX3hM//qc=;
        b=meR8UF+eY4vwy8L1coc8QTUsNRXsxjIjUB+AJz+j4e8GMZyV2NelS6vBMzUgOiZ6VW
         yEfFvibPoADiabFixs0ggL7YkpNaD6fPCQZ9K6Kut+Eh14V/OD0AGrVwhavbRkRLp3Tx
         Gb7i+04/LL79hQCMzbz8iWeB93x5O9sYjNUCABxAepvU1L0FuSxDezXF3vKzyFxxOe46
         4o9mM+Mvywh2pIkkcErcqdrdWRC2o32XOCcVBSHNQKajoKUtdTB2i3crruSgrNWkz6GI
         NljtvmzPoNq1ZlGFTPRZFXsknuS2tEOthMRaEDYNBX9ilEjpCU2LXly9hFzX5AyPRT8I
         P86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734343898; x=1734948698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+ixtMUrgX7I9rD5qvImPgp6IqifPuxLwfcX3hM//qc=;
        b=F45av8ZAyK1JG95BASXeAbiZqsVqcDsgNNmTJ2g5p09evmP/cZXtMGG9bNGHCXhYrH
         92p53zvZIBaatDPJ3qBGpnggMfQ38Wwzg3MLAT/R8D2Lrw1a3D4j6SVx1CdMCHGd+SE7
         6kU4ZWtMCs+DNoeFSdjtG9KR22UGEZ644WB3oC9VIRWns1/JckqcOZgKTut+afcudrv2
         GTuFUvCBqpyDm+s2/Br4NQgPIxXd4iaR1bgUsAco+81gCrm8WjU6/Lu32GwXE9t8zmkM
         CQY+DqUthIuG0zPF/sCdeizU8mO63ASE44vnilqxv51EyZfSb7b4xXt5dY8ULxDUEu4M
         m/6w==
X-Forwarded-Encrypted: i=1; AJvYcCUPlvGrGu6D1S0K0/lY44fZ4gvT28l9NniG2CF5BXypSa25tpwh/FO+JdRUDr6TWuPUx0gdIg==@lists.linux.dev, AJvYcCUiW9vobMvgs7u4V5pggcuIQGfOJXgth0y65x8AC4mRm51ueRyW4S90ENPjqf82RcHYQTn8/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWa+mdCfb5jDAaBDeT4Ex3uyeZUrE+VhoUZemJZ6bkJb8MjP/f
	pMeQ0S7boJAw5rb6wi4BscUybPlKDIBq+2nB8Rza2ahVnkO5LO8y
X-Gm-Gg: ASbGncu7YVqt96hQTzYo8cwzAdPXl6zvQwn1v4lyka1Pkz/XykBrDTtqt2DYXk/UgEM
	wbRKoMLJtBeBbQ80IFuMkdjws8EaqXMcrXgjvUFkEAJeRgp7Nk9ywhEl/S/DaPFSKYVuqkGje25
	RWxdvl7MDlfUQkOuARTmEf7UHgaM+eB6OHiQkyGzuRdg1z3LH9ro7EMMnpguo3y7AxO0qnYc8e/
	7lrZ7+aYoGqm8K+eGpYn7OCi+UVGHzOlE9zcj4Ml6eWgGToGRz34XP9t91Ge+hkDqTJKySO3iKx
	jD3Rm6iH0xMlWjecfa11FG0=
X-Google-Smtp-Source: AGHT+IGkvlAjtALOBMooHfO7cK9L9lvwDBwHCDIhwn8y88sRHLlwLffLXlgmsZ5Mm6dr710N1QQFRg==
X-Received: by 2002:a05:6a20:a11c:b0:1e1:e1c0:1c05 with SMTP id adf61e73a8af0-1e1e1c0202amr16720966637.9.1734343898208;
        Mon, 16 Dec 2024 02:11:38 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3a513sm3824066a12.72.2024.12.16.02.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:11:37 -0800 (PST)
Message-ID: <554ff96b-5be5-46b0-ac8b-f178394856f3@gmail.com>
Date: Mon, 16 Dec 2024 19:11:33 +0900
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using
 clear_and_wake_up_bit()
To: David Howells <dhowells@redhat.com>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: Christian Brauner <christian@brauner.io>,
 Max Kellermann <max.kellermann@ionos.com>, Ilya Dryomov
 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>, Akira Yokosawa <akiyks@gmail.com>
References: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
 <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-8-dhowells@redhat.com>
 <3332016.1734183881@warthog.procyon.org.uk>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <3332016.1734183881@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

David Howells wrote:
> [Adding Paul McKenney as he's the expert.]
> 
> Akira Yokosawa <akiyks@gmail.com> wrote:
> 
>> David Howells wrote:
>>> Use clear_and_wake_up_bit() rather than something like:
>>>
>>> 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
>>> 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
>>>
>>> as there needs to be a barrier inserted between which is present in
>>> clear_and_wake_up_bit().
>>
>> If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:
>>
>>     This operation is atomic and provides release barrier semantics.
>>
>> correctly, there already seems to be a barrier which should be
>> good enough.
>>
>> [1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.clear_bit_unlock
>> [2]: include/asm-generic/bitops/instrumented-lock.h
>>
>>>
>>> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
>>> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
>>
>> So I'm not sure this fixes anything.
>>
>> What am I missing?
> 
> We may need two barriers.  You have three things to synchronise:
> 
>  (1) The stuff you did before unlocking.
> 
>  (2) The lock bit.
> 
>  (3) The task state.
> 
> clear_bit_unlock() interposes a release barrier between (1) and (2).
> 
> Neither clear_bit_unlock() nor wake_up_bit(), however, necessarily interpose a
> barrier between (2) and (3).

Got it!

I was confused because I compared kernel-doc comments of clear_bit_unlock()
and clear_and_wake_up_bit() only, without looking at latter's code.

clear_and_wake_up_bit() has this description in its kernel-doc:

 * The designated bit is cleared and any tasks waiting in wait_on_bit()
 * or similar will be woken.  This call has RELEASE semantics so that
 * any changes to memory made before this call are guaranteed to be visible
 * after the corresponding wait_on_bit() completes.

, without any mention of additional full barrier at your (3) above.

It might be worth mentioning it there.

Thoughts?

FWIW,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

>                               I'm not sure it entirely matters, but it seems
> that since we have a function that combines the two, we should probably use
> it - though, granted, it might not actually be a fix.

Looks like it should matter where smp_mb__after_atomic() is stronger than
a plain barrier().

Akira

