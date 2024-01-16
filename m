Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BED848D
	for <netfs@lists.linux.dev>; Tue, 16 Jan 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=contractor.linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=contractor.linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=contractor.linuxfoundation.org header.i=@contractor.linuxfoundation.org header.b="omu8mfq2"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso86177581fa.0
        for <netfs@lists.linux.dev>; Mon, 15 Jan 2024 19:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google; t=1705374270; x=1705979070; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Onvocl7z9tTV39RCCW1Yld6Uw1oloVdWrBn7K39z6I=;
        b=omu8mfq2dRZ4OxXubq8WXhWTMyDgODEW2cAU3qFXoFNvS/az/Ovi5208G5Fom9XbHB
         9lCYWadwO/PjwYzijrxIbTTZmHa6vvtXrjr86cMdynvOWdgZbNY/S3oEzyNDmtEAEsFM
         GiTAIFEuxu6rNL7jxZPQoaZieRlmFEKTMItf5ulgdE5eJOHuKBfClNn7R+6hNHAVvHgl
         1P+he5ZwaPLyYHrZPyu5SPgfzlkliiBlRjRxSY3Qi0HiP6I+KRQsDlgdFR/IYPCxXKzV
         s8fEDx2LLIpq45DutkJ5gOFj/6nyEPzsUJTWH7a2sQrNjIxidvsE88gfh68ze1wLDYaE
         P1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705374270; x=1705979070;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Onvocl7z9tTV39RCCW1Yld6Uw1oloVdWrBn7K39z6I=;
        b=wv6LbSZ0W31yR+4U3cs4RSBXVGozqgWuXG9onpVHopnJIJvCHDRGA0Vllx89/c5C6b
         bOoT3Ox0Vc/H4tSF7Lh2dFODyug1gGKqfP91wy9V4E8s4z8GSxhhE0IYEIB+iHPVOWpi
         j4h/qm2rGdr6jrL9iaoj+g/ttonZt/limpSbQgr0tK5jnxX9tO/x+pl6WwXsaQWnutWX
         MmJqvP44elewc00VRtCcDSZc/2cE2EaTFDytlh0c33NWmCYQ5tY3gX0OStY/RVSQPF/t
         OGQupL72tPG161yQFXhsJFKjIa1mRib9Xe6IMhShYHNMLw6PUxCpfUblwsbqYa89ibGo
         7jLg==
X-Gm-Message-State: AOJu0Yy9NK0nnlflP61s09nOtOw3VACHDfHxzcJ508yt3pPvVic0ozw0
	onRtGJ6EfVHUhIKE35JOaHZEPuaraaapGObYRtx2znkaaSkUjBK/smYBad2Lq3g=
X-Google-Smtp-Source: AGHT+IGzHBg2DBy9QaPYeDo2jr4wLxDAqNO0xIUyyPDFTDHLrAq7VPeAGbm2fSzZSeQKgX7T7aJq9l6nFsibyriaKIk=
X-Received: by 2002:a2e:968f:0:b0:2cd:cda6:55de with SMTP id
 q15-20020a2e968f000000b002cdcda655demr887923lji.14.1705374269979; Mon, 15 Jan
 2024 19:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Tue, 16 Jan 2024 08:34:18 +0530
Message-ID: <CAH=dH9-CShTx3LJ8xu4yOZGgwUoNdRfjesqn6=az2xjNSV-5Mg@mail.gmail.com>
Subject: Test Mail
To: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello:

 This is a test message to test successful delivery and start the
 archive for the list. Please ignore.

-- 
Regards
Shyam Kumar
The Linux Foundation Core Projects
