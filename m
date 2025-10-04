Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB234BA46
	for <netfs@lists.linux.dev>; Sat,  4 Oct 2025 04:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552269; cv=none; b=AwTUwFFQkWdqenIgfnBOsVHhNP4T7gMlzD5f3vpPVe2Y0MXeHgit8r/YBl6tWtZV9Ydg0Za2iayxBQ3UwAT+yyVlLyppeRsM7U4SjvMcWgWejnCzp0aD4tS4029MpeKbsPAYyP2egUQ/l+3dks9HacnG9USrwepMvds2CijpiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552269; c=relaxed/simple;
	bh=enoINwlA9+PevoMLkOQfPIAcWmrKh+doHnEubrvsPIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmSUkaV9lsNamY9mXsJgSzsdsffZ4lM1oZn1dhIQYJBvNpVd/bhxcy0MEDEQGQ2LSnPlf2oq74sDEj/x8C8A9UpZQmnRcCrx0mBN1tHQ2JLWqiNxbIzfWyGqVorPFDEbkIfu+zqD/BQNXsrH7QVL31EPvomQCVcuB3YjjOS1hFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDsLNyJy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDsLNyJy"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso2178043b3a.2
        for <netfs@lists.linux.dev>; Fri, 03 Oct 2025 21:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759552268; x=1760157068; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StwDBKa8ZRSfrd7VD6MhCNqBvOmQ/m+xhmau3mnSCHE=;
        b=QDsLNyJyfgl8z+CAs1TfwkwwfyWF1RKNwJo8X8leehiglG2zEDtB6YexkXsItU9nXQ
         SyFcvVo0kVCiEAcQuRLGM3qZN0KdAjSYYTnqDtegE+Dgab35vy4MQFO6WlnD1u6fGIJB
         ekb6M/i3sqpJ8FurJF0/SZZmVFn9GmcpZm2YBaou5DclLwrv0hOYsqwkYx6IBXcXN9w5
         +9lo6TPGuQdx/cmgmIKcAV3AKFiX5sYKYLNOISA3/mBSSDuEZcd1D+QPpzSrQLOW9JJV
         S3cQvFEngLOLcmPt5dQ3i7/s8Q2bL9Y7FhhNGrhx1S9N7AAGk/znXqdVTqRv4CANDPcQ
         PC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759552268; x=1760157068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StwDBKa8ZRSfrd7VD6MhCNqBvOmQ/m+xhmau3mnSCHE=;
        b=V9WqKAdTjh7kekGpSygjKpAdESSPxp5WIfFT9kU1+HJKZTdFD3tCuCdLKGetOLyxh/
         Iay1YisrNrbSRnvucFdEft2SZMlJj0XBzDXcWAq8XMjHSWzL9KprHzbMYXbFbDaexYYr
         ApvlsBgl0GWNeXVNWW7rtEdbq387IjfJ0zFny0TFdLd17kCAYY6S7IYDu5P4bXVb3J7U
         W4lzEZtYXzPqn7iVdO0frZWtZtoDy5dLzX3V9Y3fDUqcWZ5ktQi5C71X5N+GSwalaLBy
         Dnu+Ulhkcch0enEXJqr9efhPyZZIhg0Z5xIeIcCGW9xdqFP3tUFHce7IH3ksNf+XkSul
         CPXg==
X-Forwarded-Encrypted: i=1; AJvYcCVWugZIk2gaPKrcfGAiCJOB1BFFjblNQp6f7PH99pvIhW5rKcxYDmObtv7qrP9/ZV2OVr+z8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO3Q56/VgVXLgUfbfIrYZfTjzjyYHjYVrQTfkalNGIA03l3H/Q
	ZBjlnOiw3KjOf+8Qa6PQm+voWDw36xLUDQpz4brdKRQLStnVDTKlxTUn
X-Gm-Gg: ASbGnctAxJtSMJ9LmxqKqG79OUOKe1v2ag5ibsbdyZ5+7JOjrXZKrF8TekKL5Rqvkgs
	njdvVaOVizTqrnOpVq0MRpOs+Js7i6NsSfDrb44TgPcEYu9qae1At5hGWB1xgbzs2t0/Y3re2D+
	Opk3VUI32xpY9pg7IZD5uRkEYrQBKAWlUbOCYxI/xvn7xmlWuXLoVKNsnC6Wn1gKnmUQYqmXoD/
	XAPlQ8jwuJP/GDA+50Gt22loTzwB6QE9oxN3gEtom/0gudKk1petgyvQfYfxbb30wqjTS3s6y6u
	o2KvGgwmTlNr1fyDOmMMTN8N7otBx5POsdXFZInxXz6aIuGfQ1S9RSBDcEYzX86Byj65xX/zCZn
	BoZN4ku3xetMla+UIUru11mSNd8I2bm//sRojjMnEKPPzB1W5GqpB5OiUUEZhUJXKj4LuRkM=
X-Google-Smtp-Source: AGHT+IGFVdu0idHFioNc6W6G3QpB4+em7I6xbQXdwjM7auYWjIP5jrn2CpWgS3aswdOPecIYETyQ3A==
X-Received: by 2002:a05:6a20:72a8:b0:2f6:cabe:a7b3 with SMTP id adf61e73a8af0-32b62107c29mr7468985637.50.1759552267731;
        Fri, 03 Oct 2025 21:31:07 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.90.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1b73sm6413167b3a.28.2025.10.03.21.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 21:31:07 -0700 (PDT)
Message-ID: <9a7072cb-840f-472a-9e22-a5252e52ef48@gmail.com>
Date: Sat, 4 Oct 2025 10:01:00 +0530
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
 <yms8llJZQiWYVxnbeWEQJ0B_S6JRxR0LQKB1FwVe0Tw66ezuA-H1qZVCyuCUDtsw7s7h4jHTwTh98XivLW3vvw==@protonmail.internalid>
 <425ef7bd-011c-4b05-99fe-2b0e3313c3ce@gmail.com>
 <6t4scagcatuba7hjy4aib5hqfgyhc4wofegr2jrl34wwa7fsyq@5uwpzmpixm7o>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <6t4scagcatuba7hjy4aib5hqfgyhc4wofegr2jrl34wwa7fsyq@5uwpzmpixm7o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/25 21:22, Carlos Maiolino wrote:
> On Wed, Oct 01, 2025 at 07:19:13PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> On 01/10/25 17:32, Carlos Maiolino wrote:
>>> On Wed, Oct 01, 2025 at 02:09:31PM +0530, Bhanu Seshu Kumar Valluri wrote:
>>>> Fix typos in doc comments
>>>>
>>>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
>>>
>>> Perhaps would be better to split this into subsystem-specific patches?
>>>
>>> This probably needs to be re-sent anyway as bcachefs was removed from
>>> mainline.
>>>
>> I just did a google search and understood about frozen state of bcachefs
>> in linux kernel since 6.17 release onward. It is going to be maintained
>> externally.
>>
>> Thanks for your comment. I will resend the patch excluding bcachefs.
> 
> It's not only bcachefs. But most of subsystems and documents you touch
> have different maintainers, so beyond removing bcachefs bits, I'd
> suggest looking at MAINTAINERS file and send specific patches targeting
> each subsystem. It makes maintainer's lives easier, at least for me.
> 
> 
>>
>> Thanks.
>>
>>
Hi,
Thank you for the suggestion. I will split it.

Regards,
Bhanu Seshu Kumar Valluri
