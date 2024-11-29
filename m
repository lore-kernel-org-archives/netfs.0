Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19F84D3E
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892113; cv=none; b=pofHg9KKkahXkZsv88ebrDsRf2UfLBp6sS5xg4E6lGr5oKpQ3CovnKpNRYTsuS3jSmHAqZgUPDAr+UUG9qbG4dI2mJNjvFCuxLLLs/vxNsmfNyEBGarhIB+QpWCDCSKBFwiY2E3bkAE8+9GEowfG5bBcxv5vxShMASIs2sCtnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892113; c=relaxed/simple;
	bh=O9a3P91RjewXkY9Vb24JTH2RFu7MA/UNMj6F+7Ja3GM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ExuV13quERP1QArF8MaRho6KpcoJFjfnYlCCOl8uHOoZAxmPWKsl3ZpDCvJyUeUTrVHqSY0yoTdQuSjpsO4J0KWPVX+pLiIL4zmv+KEuiJKt2UiyQtFM6aobKFxa16uNrFkAQSbhpwHSyeqVSxi8xwRSbOrsWb/VjRf0PBWKs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FGUqD/YV; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FGUqD/YV"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5d01db666ceso2163991a12.0
        for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 06:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732892109; x=1733496909; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O9a3P91RjewXkY9Vb24JTH2RFu7MA/UNMj6F+7Ja3GM=;
        b=FGUqD/YV2DjvZOc+p5/+/rz3y32kyX4L7CaVQRxJpiIduEO/P4G3SrQ41D7cSy0Dad
         PttT/xLgNKJgyLlVClKq1VrBdwiepfO3mbB9iWwhhK45OGBblXbIHGXI5MUoKoSEEG4a
         f7jG1T6jMfNRdxwHi9nfkSKLLGYeUPzLDh13K3GDaQjSZ7VUZy16CHdBlG7WewjXIrnH
         JpZDVkDmsXEehebpOPoJxCHT7It548rCE9J5Ziss8u44xXbhsVRFn3WtT/wiD7IbhrxT
         uY/Ivj6QDVmD0H8ZCNdpbo1xhoR8F+ngp+gEqjqbT3vRt6UxqSbA3rvtKN7iAqmlqxO5
         L2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892109; x=1733496909;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9a3P91RjewXkY9Vb24JTH2RFu7MA/UNMj6F+7Ja3GM=;
        b=xF5dMbwOMazNP1bUYHLO+voIn2KCNKfifgQaa8bn+tywkoIb8CSwCexdV0G0log61w
         02ZXjM7amrNZrw5N3n5QkmzJG8kIkuCHJ3S4U6tXmJVwV7i3RKhtYJXpdVVGog+XOFuj
         lYBYdZK/WDcS4FLbPtdLmJJMxQk9VbbcWAuCVY8sz6Day9SeII8WLpP6IUPPKJazURWy
         9o2QkdCXfR2zayXnQVCnuTgI6DYA/YDhGTsA2+USV3zc0zEH8qI5RCeVvdwtBmMP83Du
         CP3u9CRe7xGiBzqWF8Wj/yVIHxm/8UTnVeeFsw2aT3ejRkN92Q1NX4c/7IjC70eXb2Rg
         carQ==
X-Gm-Message-State: AOJu0YwpAn4fGIl0llVBwhSvBzXNYgM3Md6cskL3g6raVBxiFaIwwhdy
	RRRaDv9XGdQFLo6s60ZmVKjCTs75bLTWIn0iRQ3W5pikU+nuwAtunzjhFQSPBtnD98lLZbPign9
	V3ktOjaX9GffrdVwy82tqPNHy1Xgy2/rguhbYwKBXi324kuCY65lFpuvA
X-Gm-Gg: ASbGncvmAwi0PZS+0ZAiJxjwo4Qg/yDsUoJEe3LkivZ1zRU5Hq2jWWfsr5QYr91uHdB
	QB2sgiepqgiE9mUYBF9PwgCStPf1Yyta+3kwLx786YEgVQvt9k9EEobGHzmEb
X-Google-Smtp-Source: AGHT+IG51/ctnpWAAyPJ/UsJlBYumpbLHWzlJDXWMRRsSq/xkkaWPA5otoCRqF2ZE2cHTksBbDVGzPfBHaxGmz3W3Fg=
X-Received: by 2002:a05:6402:4402:b0:5cf:f248:7715 with SMTP id
 4fb4d7f45d1cf-5d080c48680mr9742804a12.23.1732892108854; Fri, 29 Nov 2024
 06:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 15:54:56 +0100
Message-ID: <CAKPOu+_JUNO5EZosu00H=tZsgfCAzQkBBkJjVfOHYrX_6mHEPQ@mail.gmail.com>
Subject: New cachefilesd implementation
To: netfs@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

the venerable cachefilesd has caused us numerous problems. We have a
rather large cache partition (several terabytes containing hundreds of
millions of cached files), and cachefiled's culling would take a
thousand times longer than it would take the kernel to refill the
space that was freed. cachefilesd had been running for months at 100%
CPU with no visible progress. This made our fscache unusable.

This problem is caused by cachefilesd's bad choice of data structure:
it maintains a sorted array of object pointers, making
insert_into_cull_table() extremely slow and CPU consuming. I figured
reimplementing it from scratch in a saner language was faster than
fixing the old C code base. So I did just that, with C++ and io_uring.

This is it, after barely one day of hacking: https://github.com/CM4all/cash
It is not yet complete (hard-coded configuration, no graveyard
cleanup, bad error handling) and the code sure could be prettier, but
it's already running on our production servers and has cleaned up the
mess that cachefilesd has left behind.

Max
