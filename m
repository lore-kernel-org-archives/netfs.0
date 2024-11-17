Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40371DA60D
	for <netfs@lists.linux.dev>; Sun, 17 Nov 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879749; cv=none; b=ClMAf75eLz28fBboq0FFLo/pjwcI+iWOFnVFf4KIn3E7iwSKsFipdZFjK03fKI/IVDDCUoqDeUQV67TOKLRwPstreCY2GOh0zCxkpJb8Grr9I4g9yoa5ridYxXN2ioVyruYI26ujVmQPFXskVfFi3Zgrk32G/nUof3S0trmCaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879749; c=relaxed/simple;
	bh=fbnwBa/ZpueSh9SqikfHGUoxX6deXqluvSX6WSJQJJs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q7hUJcRYdKb3vzzQcUNRHREen7jgCHfMFlGhTU0oTCVJkwjGxuI+5x4NV9XdGpHvFybMi2Oi7FQiZvGRuUI7jrXIs89cKVNbKtOhWlkuVkceIbbDY5CNyxTbJENaHZMoyx+IY8QFlvM9koVxPA7P2ftD6N0Nk0Si0ccz+lz/5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=AseKx6Tt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="AseKx6Tt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ece998fe6so253347f8f.1
        for <netfs@lists.linux.dev>; Sun, 17 Nov 2024 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1731879746; x=1732484546; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr6CSSq+yYWOM7mVKH3wNw8lI+twmShT9Ch+V8e8Hus=;
        b=AseKx6TtBuYiN+KotfrYAaHb8QLXOhr60GW1DW0cvk0tkWVNF3479hTzs2q1Pfmn5b
         imbM1/Wawz/w0Misfo6Mm8WV5A7ElKlyx89mX/EP00m/4SGO8NJeFTd9Bg34+CSOpnye
         6LF1hcGCL7T0+Uqh2SPF7h2pEtBKLFWH11V2ds++E58x6T8kkamom0bXIUuZeg8baasE
         GJSpqSlrJT+icAfJO0niFO9v+7maSU79YLVA46Ce6aYDiO3/aDy/JnJY2u0UcdQv0Fo7
         /NJ0wreCD4l9JFf3ibiy0lFpp0yL9YAHpfLj6x03p/Jd7JS+gJnSFaY0HN94ykf07oYv
         J5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731879746; x=1732484546;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr6CSSq+yYWOM7mVKH3wNw8lI+twmShT9Ch+V8e8Hus=;
        b=B/+C9h9kBDHLKG0y+I2o6YbQBcjjb4w+ai4OUGRgE51FP/U/Feht9/G9bF/ZqAW798
         u0bXptKIuNOyjyVn7tFQx9H8t64azxLad0lzoKu0xEnEFPNVdwkRnayzVUh1ct++2+q3
         lcVIEv/YxMp92Kzmqd4pIMwrXLXJc1ctHh6Zfh5DjWgQnehcr5zSKwj1Xx39moqMc7Eq
         bsZ3VUAjcmZAd8crgnZwz1SwA51U0vO0nADyaPeUs71ZK0AFV7ar6UcFV2wwHcBVTA7l
         2Fsu44XsbMZ8lIHtddwaebOvAzBNBgqgj2kUUgDYWCcjtY8NOUKNKuv6GDt0hAaU3EME
         OfZw==
X-Gm-Message-State: AOJu0YwzkUrRmHiW/5aGxMcEJCYyjThV/6m1fBkl0tF8Njm32TV4EFiC
	Trji4VXgkdHK7LgEoUMZkDxQOLWHrtelcP8QEhuMHQ2P+suEtR2SCDug//DQRwc=
X-Gm-Gg: ASbGnctpvm/p3G6zDkUmxN9Bw4TRcgt6/XePx8uHjKX/Sk7E7dC7DwXWHaTPO5t1DmF
	leiNokTMSQRAhBYVBctx6tb2JEPrcW+jemVHx7q/5AN0eAFPRm8MHSWqoP9gNIuCd9SM8lNQc2F
	FNoPXGOBtMe8a2fCiuAy0NQ+5rHjh1xOjOX6C4WtYeWha2sRSKBK1OcD1oLPHrXQVvwfZb2Ph2B
	/yoMvRptnXMAVzG1T/aDOYWbGQ2XBEsyidM1wdP/ADC65pXY7cXqcUcPJGpIC0zXCPX7eHRq8WA
	XplkHQ==
X-Google-Smtp-Source: AGHT+IF+9oJFbi21AiEkbm/uejQ7RsC8IrNLz23sCIY+EPlWop6ZGwOrWSuUxfNkWi1PvkVhegUgpA==
X-Received: by 2002:a05:6000:2d03:b0:382:3ef9:dfbc with SMTP id ffacd0b85a97d-3823ef9eecemr723300f8f.5.1731879746245;
        Sun, 17 Nov 2024 13:42:26 -0800 (PST)
Received: from smtpclient.apple ([2001:a61:a4f:301:d900:ed0f:882d:dc03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382491e19bdsm477489f8f.16.2024.11.17.13.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2024 13:42:25 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240830-weihnachten-umtreiben-d3a9f1aee2e7@brauner>
Date: Sun, 17 Nov 2024 22:42:13 +0100
Cc: netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 dhowells@redhat.com,
 jlayton@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FE1592EE-F840-4E90-9177-FD2D03261E3B@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
 <20240628-dingfest-gemessen-756a29e9af0b@brauner>
 <4A2EAFA2-842F-46EF-995E-7843937E8CD5@toblux.com>
 <20240830-weihnachten-umtreiben-d3a9f1aee2e7@brauner>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

On 30. Aug 2024, at 15:17, Christian Brauner wrote:
> On Thu, Aug 29, 2024 at 02:29:34PM GMT, Thorsten Blum wrote:
>> On 28. Jun 2024, at 10:44, Christian Brauner wrote:
>>> On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
>>>> Remove duplicate included header file linux/uio.h
>>>> 
>>>> 
>>> 
>>> Applied to the vfs.netfs branch of the vfs/vfs.git tree.
>>> Patches in the vfs.netfs branch should appear in linux-next soon.
>>> 
>>> Please report any outstanding bugs that were missed during review in a
>>> new review to the original patch series allowing us to drop it.
>>> 
>>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>>> patch has now been applied. If possible patch trailers will be updated.
>>> 
>>> Note that commit hashes shown below are subject to change due to rebase,
>>> trailer updates or similar. If in doubt, please check the listed branch.
>>> 
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>>> branch: vfs.netfs
>>> 
>>> [1/1] fscache: Remove duplicate included header
>>>     https://git.kernel.org/vfs/vfs/c/5094b901bedc
>> 
>> Hi Christian,
>> 
>> I just noticed that this patch never made it into linux-next and I 
>> can't find it in the vfs.netfs branch either. Any ideas?
> 
> Picked into vfs.fixes.

Hi Christian,

I just noticed that this patch (again) didn't make it into linux-next.
Any ideas why not? The link just says:

  Notice: this object is not reachable from any branch.

Obviously, this patch isn't very important, but maybe this happens with
other, more important patches too?

Thanks,
Thorsten

