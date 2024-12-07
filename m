Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E58126C0D
	for <netfs@lists.linux.dev>; Sat,  7 Dec 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733566203; cv=none; b=rQqi+gR+jvMNn2Vx05uMlTC6Rpv3hjeIljb9LEiIULHgdVBTz6GWcnv2kQnFH+zi1O+KRPEoX0ReuVeSmKtgVji/LBQDCg+H42dJlT3U23Sks0TtdqVsC/2vEuXb60hPEgKSqcTH786nJODMwVrkMksU6NMWbKF2CeBmxhXnGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733566203; c=relaxed/simple;
	bh=p2edH10DS2izFB/jzZz2W+zP4whcYevquQhC4IC/v/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4EdbMf0PmzfkiFEk+zaKTD9wBDyVGhfzhXJERVqMeddndV5xtEowpB9eSH22A14fraiIZ3SS0kBK1tIDvldpAQkggQOI1Uw1AGT7xtxMU0SPxdJJUOO3gsTr/SUHeCfcvMJBUE+Nl/wFdHld+J5CmR+u9fNowL3Uf6Z9MjvnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETAHhP7m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETAHhP7m"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72599fc764bso2267208b3a.1
        for <netfs@lists.linux.dev>; Sat, 07 Dec 2024 02:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733566201; x=1734171001; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BHlvc2h6RbQcsZ4MoZvKFrwrzmCNN8+Ik8anzK5kag=;
        b=ETAHhP7mHI/ezbCoi3SK0BIZKU3h2BieB3KqGIjI8k1peVBDUGmqLqRQLbmEE7FIMM
         uvWx8nYPyAxG0mvRkNJMr+X7QSjwfdBheYaJssebeMCU9ODPoi9kzn0TBjFqpiLzFGo5
         m5H3npa2mfSWlSsf05BasyXd62DxeRDRHy8dGAxE0Yi1M5w/vBDrzMpu4x5KUDzcUeWi
         QYEkW5EO+zKG+30SOxRhDdNLyNS57MCjntVYiOEOeLLo9Br5NwcHCzPmlg2qLLZrue1Y
         5Uq9/34hw8pBMismWqYhCct2gSjfXo4xUa/vO6Wf/uub8KC2yyN/F5V4lqe5fJi/LqQA
         znBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733566201; x=1734171001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BHlvc2h6RbQcsZ4MoZvKFrwrzmCNN8+Ik8anzK5kag=;
        b=SPMOo2I0vphbo7h3f88yfd/KXuCWaz67CPQ81fhgCou+/EkmexLO/cStd3AddtXTJb
         lnpYMJElVyOk2QZIm3j/MoKZmD0/eH2Y6rKChWsbyTPNyCLVHgm74s/J3Bq3/XueENd0
         s0s+5QwYimv/mkv3WtKWoQGh+s15Zz7luPYd14zI0eT6F3/JqJ4K/wMYYYh5L4Zu6Hst
         biMlq6AINhMwkZ0j0DQOupvPtmVGscsUQYgc7df+4v9akU/O154qG3DIzKzq5SYbMSag
         Exysff1WICn+/vsQzZo7j91Jt7bJ81pkqG7/cGGO/sx9PQh+on0bVAHbuBY8DbgVxOYb
         vwWA==
X-Forwarded-Encrypted: i=1; AJvYcCWkSM+u1hR/BRiSh1FGzMGI3Qsvxn/hYESSPxFps9CNU5wA0C9N4Jc7FZLrI7OQyxHQj03ZyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBLBbET1Gn7/gtID513DHGXetJ1gIipbkCFZ6syCFUzFAbq1J8
	rjykqF7HU+SYo3qISAVyUmpXZgRWtGGYGtXn2NqCOc1fvgPAUH7C
X-Gm-Gg: ASbGncvYWSTxomLzoWYdxOGvI2/yGbXaOZcnVEwMO5b+Y0Bv1fmA7zPRVFhhd7gmM5q
	kHsvi1wbfgrshVcgStWHpGpy3GZjxt1Hp2OIrL+jvQZTrrKKsvm208gWeHiREIkV4ZuGHCLtwTN
	ypDDC3NwCFI3TC4nqkTLNRLI+415pRwEop1Ka6Ghppx9YvqtBWlW1l/3mwZ7HfbmYaCpXYJuVuA
	2zuSNhI7HUhpAfJrxdslhIHfhSxjtBfJpbmnNX8FeedKuefGhPGpKf0Q3pb51kcSbgNx8TBmnEg
	2vKSxPv4sQdPUb+u
X-Google-Smtp-Source: AGHT+IEwKHhlxGzah4NtZ1B9CRa8dut1jgF5vSw0cszYeuNUODXBUIVq9msGMlK35IELUgHoTm1KAw==
X-Received: by 2002:a05:6a21:168d:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1e186c1dd91mr8250378637.12.1733566201479;
        Sat, 07 Dec 2024 02:10:01 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ef5b6sm4218484b3a.71.2024.12.07.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 02:10:01 -0800 (PST)
Message-ID: <9cc62b69-7cfb-477b-bec1-3bbcc49a310e@gmail.com>
Date: Sat, 7 Dec 2024 19:09:59 +0900
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/netfs: Remove redundant use of smp_rmb()
To: David Howells <dhowells@redhat.com>
Cc: zilin@seu.edu.cn, jianhao.xu@seu.edu.cn, jlayton@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, mjguzik@gmail.com
References: <69667b21-9491-458d-9523-6c2b29e1a7e6@gmail.com>
 <20241207021952.2978530-1-zilin@seu.edu.cn>
 <2011011.1733558696@warthog.procyon.org.uk>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <2011011.1733558696@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On Sat, 07 Dec 2024 08:04:56 +0000, David Howells wrote:
> Akira Yokosawa <akiyks@gmail.com> wrote:
> 
>> Are you sure removing the smp_rmb() is realy the right thing to do?
> 
> The wait_on_bit*() class functions, e.g.:
> 
> 	wait_on_bit(unsigned long *word, int bit, unsigned mode)
> 	{
> 		might_sleep();
> 		if (!test_bit_acquire(bit, word))
> 			return 0;
> 		return out_of_line_wait_on_bit(word, bit,
> 					       bit_wait,
> 					       mode);
> 	}
> 
> now unconditionally includes an appropriate barrier on the test_bit(), so the
> smp_rmb() should be unnecessary, though netfslib should probably be using
> clear_and_wake_up_bit().
> 

Thank you for clarifying.

> Probably we need to update the doc to reflect this.

Agreed.

I see that wait_on_bit()'s kernel-doc comment mentions implicit ACQUIRE
semantics on success, and that of wake_up_bit() mentions the need of care
for memory ordering before calling it.

Unfortunately, neither of those comments is included into kernel
documentation build (Sphinx) at the moment.

I'm going to prepare a patch for including them somewhere under the
core-api doc.

WRT memory-barriers.txt, I'm not sure I can update it properly.

David, may I ask you doing that part?

Thanks, Akira

