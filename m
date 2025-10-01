Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C82FC89C
	for <netfs@lists.linux.dev>; Wed,  1 Oct 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327102; cv=none; b=Y5N+sSFmcHYQ3wfoDy0IeN1tTSX0FFcEUQkUwhzlA/FISvsc3m+QXMfnWDRN6DzjQV0WB5Blzcy8sYepQosUAtXPTt7zG0kNSSKkts+VVsfPcMxqcfOpI/sKzWM5pqCVXiUx5Y6SCojITM9AxBWma9ONB2oSAzjAJ8/TclbxqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327102; c=relaxed/simple;
	bh=AErz9DRE4zvoV1QAhCMy5Ce5EIwMk6a2u/GPbn+LmQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrXM99WYgK/78zOWbQV1FGINg1lGFR9AjBFffFq+NE3KVsmwdraR1aDTJHOiRGbpz469IhLGPORahbwsW5nT9A7mksG1k+Vq6xULgMDYhgPpskKfDTwUAMOmsnmVplFQ7IJAGocJQIP+I+MpzaErWuL7hLtFSTsxM39xeX5cDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+guwJsA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+guwJsA"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-782e93932ffso3973575b3a.3
        for <netfs@lists.linux.dev>; Wed, 01 Oct 2025 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759327099; x=1759931899; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHICQ9kYf8w+w6O3p0zJJOxecrN+M89vOZ1OdrVwWEc=;
        b=O+guwJsA68cvsC0+eemgI7+V7GR5pDV7iYFPeSDLPuk0d6nQPVoP1sCKdU9IB2PG7e
         dAqdsFNlRTjqjD4QJIM0y1HEjp5xmseOThboHqYMeHZIUemkxdexP3lD1EQIe+scLqa1
         8W6Mfbl7kFgUJ6q+uf7G/2u082IcjbAd0n6MF7E933aHuJA0CweRKO7d0l0oz9Fdo+MR
         UmxfkMa4bOIDURsIJJMvJEDhDyoAXYFfRMOjWQOYPQzlvYYy3V+OtPta+oXrmhJ2ec8D
         ABzA3hLUNJ8iWdQ1W7yzfwlnlY2OkxaZkew7nFfTQtTcikxhdPZLkT03lmNTWrnMVz7Q
         qkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327099; x=1759931899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHICQ9kYf8w+w6O3p0zJJOxecrN+M89vOZ1OdrVwWEc=;
        b=TNQXYtAAWnRjmkcLs7J6UBEEeNm/NtEF9814Bi/hlHD6x0Dn53HH0rgLV7ETCpEUYr
         RJPke3D7HtwoNUZhga5xIsBkUW0vUpd3RLdPFTiC4RsWCbLO3AJAoaCpV2L1FaNbrFoO
         lINMD9LKortND+b+XZkfm1/GzabOt9Y2uVxxsf3pNrOlBbgzTWZC4r5lTfGK6UCJRLP8
         wCTNGlJH7cEMIgqUj1cAGqBmZAtrq2cK3XQvsENgzufmWgn6O4d/3vXJJjwRck+Wpz+R
         t9fddyop5PBUmsBi20hX0wAqVgvdnR7mx3cVLXAKOUh91doqebFXyKIq17AAVcEr1F3f
         z2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVnBV6GSV+xq8Jk1pXqIZ9iYuo9wLL/FQT4vw5zKQNtD8750RmiRg1NDQMuh/nme2Dt8LTeUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO11/4TuieL5MJ7L/XVN3Dgvd8gVJElox18d5Okccf5O+PeyEh
	+FQR74mgv+IeXs+FXe+iLd1apX07lgN1VRhDs6UQWi5i6+FAUwYSlmtT
X-Gm-Gg: ASbGncsHiLPqQbDJN/sdBuBlCEUGrnhahJ2PBeL17cwH6XStwXhQB/rSmX/+jfE9ltX
	ZoqVd35YUtlTRGl/toBSQwFKwCefxSifA4LmdIidfZcwCShDvh+5Gry3otAz1R8sPRuTYozGYln
	YOXaeO3PIZ3KYzdGbkCo/VPGb35RLO5orQEFXmFZ6jOyPx0lBpDg0TyJKTQoWsFQXravU9ePrHK
	oLEnChG5B/UJq6uqHBlLTxJdAmDP9UVKvaOYRWf6I6weKGhxnQwmEjRawXf5lucoml/ULJryXhj
	shhxUl986iBLFjL66zpbtd1AcVkwxgULyyDyIomAGeEylhf4S0+TdZ287mUePppPyXA0Dmhb5+2
	azEwHUYvJTDgKq28cS91QOvvMTwyZveZhWEGaWFekOJFhjG4iB18mCzVruVAejz3xlS8aGg==
X-Google-Smtp-Source: AGHT+IEVrUrSHnJxKWleti3ip/7ssnZbESbu792noCsfEcKl9fEdE1xbBALgSKgo50vIeSR68LO4xQ==
X-Received: by 2002:a17:90b:2249:b0:330:852e:2bcc with SMTP id 98e67ed59e1d1-339a6f38013mr4558738a91.21.1759327099110;
        Wed, 01 Oct 2025 06:58:19 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.95.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399be87425sm2129797a91.1.2025.10.01.06.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:58:18 -0700 (PDT)
Message-ID: <425ef7bd-011c-4b05-99fe-2b0e3313c3ce@gmail.com>
Date: Wed, 1 Oct 2025 19:19:13 +0530
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: doc: Fix typos
To: Carlos Maiolino <cem@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-bcachefs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <DrG_H24-pk-ha8vkOEHoZYVXyMFA60c_g4l7cZX4Z7lnKQIM4FjdI_qS-UIpFxa-t7T_JDAOSqKjew7M0wmYYw==@protonmail.internalid>
 <20251001083931.44528-1-bhanuseshukumar@gmail.com>
 <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 17:32, Carlos Maiolino wrote:
> On Wed, Oct 01, 2025 at 02:09:31PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> Fix typos in doc comments
>>
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> 
> Perhaps would be better to split this into subsystem-specific patches?
> 
> This probably needs to be re-sent anyway as bcachefs was removed from
> mainline.
> 
I just did a google search and understood about frozen state of bcachefs
in linux kernel since 6.17 release onward. It is going to be maintained 
externally. 

Thanks for your comment. I will resend the patch excluding bcachefs.

Thanks.


